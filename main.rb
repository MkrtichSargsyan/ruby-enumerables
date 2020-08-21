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

  def my_select
    filtered_arr = []
    each do |el|
      yield(el) && filtered_arr.push(el)
    end
    filtered_arr
  end
end

newArr = [1, 2, 6].my_select do |el|
  el.even?
end

puts newArr