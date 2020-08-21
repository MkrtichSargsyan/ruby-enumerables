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

  def my_all
    booleansArr = []

    each do |el|
      booleansArr.push(yield(el))
      p booleansArr
    end

    booleansArr.my_each do |el|
      if el
        next
      else
        p false
        next
      end
    end
    p true
  end
end

[2, 2, 3, 2].my_all do |el|
  el == 2
end
