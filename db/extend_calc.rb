class String
  def * array
    res = [:alt]
    array.each_with_index do |e, i|
      res << self + e.to_s unless i == 0
    end
    res
  end
end

class Array
  def * target
    res = [:alt]
    if target.instance_of? String
      each_with_index do |e, i|
        res << e.to_s + target unless i == 0
      end
    elsif target.instance_of? Array
      each_with_index do |e1, i1|
        target.each_with_index do |e2, i2|
          res << e1.to_s + e2.to_s unless i1 == 0 || i2 == 0
        end
      end
    end
    res
  end
end
