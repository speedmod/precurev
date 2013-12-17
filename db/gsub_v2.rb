require './create_str_from_regex'

open $*[0] do |file|
  while line = file.gets
    create_strings_from_line line
  end
end
