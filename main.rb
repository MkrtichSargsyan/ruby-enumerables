module Enumerable
  def my_each
    each { |el| yield el }
  end

  def my_each_with_index
    index = 0
    each do |el|
      yield(el, index)
      index += 1
    end
  end
end

[1, 2, 6].my_each_with_index { |el, index| puts el, index }
