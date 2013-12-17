# coding: utf-8
require './extend_calc'

# create_stringsを呼ぶ
# @param [String] line TSV形式の行。行が持つ値は曲IDと曲タイトル正規表現の2つ
# @return
def create_strings_from_line line
  song_id = line.strip.split(/\t/)[0]
  target  = line.strip.split(/\t/)[1]
  return unless target
  target = add_parlen target # 姑息な対応
  create_strings target, song_id
end

# 正規表現全体が()で囲われている場合に対する姑息な対応。
# 例：
# (BLESSING|ぶれ(|つ)しん(|ぐ))
# (DARKNESS|だ(|あ)くねす)
# など
# (hoge|fuga) の変換結果は
# [:alt, "hoge", "fuga"]だけだったのを、
# (hoge|fuga)(|) と末尾につければ
# [:alt, "hoge", "fuga"]*[:alt, "", ""]
# となり、最終的に "hoge", "fuga"に展開されることになる。
# また、他の正規表現に対しても無駄にならない。
# （"asdf"*[:alt, "", ""]となるだけなので）
#
# @param [String] target 正規表現
def add_parlen target
  target + "(|)"
end

# 標準出力に文字列集合と対応する曲IDをTSV形式で出力する。
#
# @param [String] target 特化正規表現
# @param [Fixnum] song_id 曲ID
def create_strings target, song_id=-1
  target.gsub!(/([\p{hiragana}\d\w]+)/, '"\1"') # 正規表現に含む文言を文字列化する
  target.gsub!(/\)"/, ')*"')  # 演算子をつける(1)
  target.gsub!(/"\(/, '"*(')  # 演算子をつける(2)
  target.gsub!(/\)\(/, ')*(') # 演算子をつける(3)
  target.gsub!('|', ',')      # 縦棒(|)をカンマ(,)にする。

  before, after = target, nil

  while true do
    # (a|b)を[:alt, a, b]に変換する
    after = before.gsub(/(\([^\(\)]+\))/) {|alt| "[:alt,#{alt[1..-2]}]" }
    if before == after
      break
    else
      before = after
    end
  end
  target = after
  target.gsub!(',,', ',"",') # 空文字列を作る

  res_eval = eval(target)
  if res_eval.instance_of? String
    puts "#{song_id}\t#{res_eval}"
    return
  end

  # res_evalをさらに変換
  res_eval.map do |e|
    if e.instance_of? String
      e.gsub!(/\]([\p{hiragana}\d\w]+)/, ']"\1"')
      e.gsub!(/([\p{hiragana}\d\w]+)\[/, '"\1"[')
      e.gsub!(/\]"/, ']*"')  # 演算子をつける(1)
      e.gsub!(/"\[/, '"*[')  # 演算子をつける(2)
      e.gsub!(/\]\[/, ']*[') # 演算子をつける(3)
      begin
        eval(e)
      rescue
        # evalできない文字列だった場合にはそのまま配列に納める
        # このrescueで拾われないものがある。
        e
      rescue SyntaxError => se
        #puts "#{e} (SyntaxError)"
      end
    end
  end

  res_eval.each do |e|
    begin
      a = eval(e)
      a.each do |elem|
        puts "#{song_id}\t#{elem}" if elem != :alt
      end
    rescue
      puts "#{song_id}\t#{e}" if e != :alt && e != "alt"
    rescue SyntaxError => se
      puts "#{song_id}\t#{e} (SyntaxError)"
    end
  end
end
