# coding: utf-8
require './create_str_from_regex'

# 標準出力に出力。実行時の引数は title_regexs.tsv
open $*[0] do |file|
  while line = file.gets
    create_strings_from_line line
  end
end
