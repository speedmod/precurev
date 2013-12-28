# coding: utf-8

# シリーズデータを作成
# まず削除
puts 'Creating Series records...'
Series.delete_all
puts 'Deleted existing records of series.'
# ファイルのデータを読み込んで作成
{ Series => './db/series.tsv' }.each do |clazz, filename|
  file = File.open filename
  begin
    file.each_line do |line|
      values = line.strip.split /\t/
      clazz.create(id: values[0], name: values[1], abbreviation: values[2], year: values[3])
    end
  ensure
    file.close
  end
end
puts "#{Series.all.size} records of series created."

# ボーカル、キャラクター、作曲、作詞、編曲の各データを作成
# まず削除
Composer.delete_all
Writer.delete_all
Vocalist.delete_all
Arranger.delete_all
Character.delete_all

# ファイルのデータを読み込んで作成
{
  Composer  => './db/composer_uniq.txt',
  Writer    => './db/writer_uniq.txt',
  Vocalist  => './db/vocal_uniq.txt',
  Arranger  => './db/arrangers_uniq.txt',
  Character => './db/characters_uniq.txt'
}.each do |clazz, filename|
  puts "Creating records of #{clazz.to_s}..."
  file = File.open filename
  begin
    file.each_line.with_index(1) { |line, i| clazz.create(id: i, name: line.strip) }
  ensure
    file.close
    puts "#{clazz.all.size} records of #{clazz.to_s} created."
  end
end

# Kanaのレコードを作成
puts "Creating records of kanas..."
# 削除
Kana.delete_all
# ファイルのデータを読み込んで作成
{
  Kana  => './db/kana.tsv'
}.each do |clazz, filename|
  file = File.open filename
  begin
    file.each_line.with_index(1) do |line,i|
      values = line.strip.split /\t/
      clazz.create(id: i, song_id: values[0], kana: values[1])
    end
  ensure
    file.close
  end
end
puts "#{Kana.all.size} records of kanas created."

# ボーカル、キャラクター、作曲、作詞、編曲の各リンククラスのレコードを作成
# 削除
ComposerLink.delete_all
WriterLink.delete_all
VocalistLink.delete_all
ArrangerLink.delete_all
CharacterLink.delete_all

# ファイルのデータを読み込んで作成
[
  { filename:   './db/vocalist_link_origin.tsv',
    data_class: Vocalist,
    link_class: VocalistLink,
    data_id:    :vocalist_id },
  { filename:   './db/character_link_origin.tsv',
    data_class: Character,
    link_class: CharacterLink,
    data_id:    :character_id },
  { filename:   './db/composer_link_origin.tsv',
    data_class: Composer,
    link_class: ComposerLink,
    data_id:    :composer_id },
  { filename:   './db/writer_link_origin.tsv',
    data_class: Writer,
    link_class: WriterLink,
    data_id:    :writer_id },
  { filename:   './db/arranger_link_origin.tsv',
    data_class: Arranger,
    link_class: ArrangerLink,
    data_id:    :arranger_id },
].each do |h|
  puts "Creating records of #{h[:link_class]}..."
  file = File.open(h[:filename])
  begin
    link_id = 1
    file.each_line do |line|
      song_id, names = line.strip.split /\t/
      next unless names
      names.split(',').each do |name|
        data = h[:data_class].where(name: name).first
        if data
          h[:link_class].create(:id => link_id, :song_id => song_id.to_i, h[:data_id] => data.id)
          link_id += 1
        end
      end
    end
  ensure
    puts "#{h[:link_class].all.size} records of #{h[:link_class]} created."
    file.close
  end
end

# 曲データを削除＆作成
Song.delete_all
# ファイルからデータを読み込んで作成
file = File.open './db/songs.tsv'
begin
  puts "Creating records of songs..."
  file.each_line do |line|
    values = line.strip.split /\t/
    Song.create(id: values[0], name: values[1], series_id: values[2])
  end
ensure
  puts "#{Song.all.size} records of songs created."
  file.close
end

# Codeデータを削除＆作成
# Code:Song = * : 1
Code.delete_all
{
 'DAM'      => './db/code_dam.tsv',
 'JOY'      => './db/code_joy.tsv',
 'UGA'      => './db/code_uga.tsv',
 'tetsujin' => './db/code_tetsujin.tsv',
 'pasela'   => './db/code_pasela.tsv',
}.each do |maker_str, filename|
  file = File.open(filename)
  puts "Creating records of #{maker_str}..."
  begin
    file.each_line do |line|
      song_id,maker,machine,movie,code =
        line.strip.split(/\t/).map { |v| v.strip.length == 0 ? nil : v.strip }
      code = Code.create(song_id:  song_id.to_i,
                         maker:    maker,
                         machine:  machine,
                         movie:    movie=='TRUE',
                         code:     code)
    end
  ensure
    file.close
    puts "#{Code.where(maker: maker_str).size} records of #{maker_str} created."
  end
end

################################
# 最後にsongs#songdataを全格納
################################
# 曲データに紐づくデータを全て予め取得しておき、songs.songdataカラムに格納しておく。
# songs#songdataカラムをupdateするだけなので、データの削除は不要。
puts "Updating records of songs..."
data_hash = {}
Song.all.each do |song|
  {
    series:    Series,
    composer:  Composer,
    writer:    Writer,
    vocalist:  Vocalist,
    arranger:  Arranger,
    character: Character,
    code:      Code,
  }.each do |key, clazz|
    tmp = []
    if key == :code
      tmp = {
        "DAM"      => [],
        "JOY"      => [],
        "UGA"      => [],
        "tetsujin" => [],
        "pasela"   => [],
      }
      song.codes.each do |code|
        tmp[code.maker] << "<strong>#{code.code}</strong>" +
          (code.machine? ? "<br />(#{code.machine}以降)" : "") +
          (code.movie ? "★" : "")
      end
    elsif key == :series
      tmp = song.series.abbreviation
    else
      song.send((key.to_s + '_links').intern).each do |link|
        tmp << link.send(key).name
      end
    end
    data_hash[key] = tmp
  end
  song.update_attribute(:songdata, JSON.dump(data_hash))
end
puts "Updated all of records of songs."
puts "Done."
