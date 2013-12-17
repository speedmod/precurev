# coding: utf-8

# 一時的にコメントアウト
# File.open('./db/character_link_origin.tsv').each_line do |line|
#   song_id, chara_names = line.strip.split /\t/
#   next unless chara_names
#   chara_names.split(',').each do |chara_name|
#     chara = Character.where(name: chara_name).first
#     CharacterLink.create(song_id: song_id.to_i, character_id: chara.id) if chara
#   end
# end

# {
#   Composer  => './db/composer_uniq.txt',
#   Writer    => './db/writer_uniq.txt',
#   Vocalist  => './db/vocal_uniq.txt',
#   Arranger  => './db/arrangers_uniq.txt',
#   Character => './db/characters_uniq.txt'
# }.each do |clazz, filename|
#   file = File.open filename
#   begin
#     file.each_line { |line| clazz.create(name: line.strip) }
#   ensure
#     file.close
#   end
# end

# 一時的にコメントアウト
# {
#   Kana  => './db/kana.tsv'
# }.each do |clazz, filename|
#   file = File.open filename
#   begin
#     file.each_line do |line|
#       values = line.strip.split /\t/
#       clazz.create(song_id: values[0], kana: values[1])
#     end
#   ensure
#     file.close
#   end
# end

# 一時的にコメントアウト
# { Series => './db/series.txt' }.each do |clazz, filename|
#   file = File.open filename
#   begin
#     file.each_line do |line|
#       values = line.strip.split /\t/
#       clazz.create(id: values[0], name: values[1], year: values[2])
#     end
#   ensure
#     file.close
#   end
# end

# { Song  => './db/songs.tsv' }.each do |clazz, filename|
#   file = File.open filename
#   begin
#     file.each_line do |line|
#       values = line.strip.split /\t/
#       clazz.create(id: values[0], name: values[1], series_id: values[2])
#     end
#   ensure
#     file.close
#   end
# end

# [
#   { filename:   './db/vocalist_link_origin.tsv',
#     data_class: Vocalist,
#     link_class: VocalistLink,
#     data_id:    :vocalist_id },
#   { filename:   './db/character_link_origin.tsv',
#     data_class: Character,
#     link_class: CharacterLink,
#     data_id:    :character_id },
#   { filename:   './db/composer_link_origin.tsv',
#     data_class: Composer,
#     link_class: ComposerLink,
#     data_id:    :composer_id },
#   { filename:   './db/writer_link_origin.tsv',
#     data_class: Writer,
#     link_class: WriterLink,
#     data_id:    :writer_id },
#   { filename:   './db/arranger_link_origin.tsv',
#     data_class: Arranger,
#     link_class: ArrangerLink,
#     data_id:    :arranger_id },
# ].each do |h|
#   file = File.open(h[:filename])
#   begin
#     file.each_line do |line|
#       song_id, names = line.strip.split /\t/
#       next unless names
#       names.split(',').each do |name|
#         data = h[:data_class].where(name: name).first
#         h[:link_class].create(:song_id => song_id.to_i, h[:data_id] => data.id) if data
#       end
#     end
#   ensure
#     file.close
#   end
# end

# 曲データに紐づくデータを全て予め取得しておき、songs.songdataカラムに格納しておく。

data_hash = {}
Song.all.each do |song|
  {
    composer:  Composer,
    writer:    Writer,
    vocalist:  Vocalist,
    arranger:  Arranger,
    character: Character,
  }.each do |key, clazz|
    tmp = []
    song.send((key.to_s + '_links').intern).each do |link|
      tmp << link.send(key).name
    end
    data_hash[key] = tmp
  end
  #p data_hash
  song.update_attribute(:songdata, JSON.dump(data_hash))
end
