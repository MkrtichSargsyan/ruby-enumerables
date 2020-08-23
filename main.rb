module Enumerable
  def my_each
    while length != 0
      yield first
      shift
    end
  end

  def my_each_with_index
    index = 0
    while length != 0
      yield "element is #{first}, index is  #{index}"
      shift
      index += 1
    end
  end

  def my_select
    filtered_arr = []

    while length != 0
      yield(first) && filtered_arr.push(first)
      shift
    end

    filtered_arr
  end

  def my_all?
    output = true

    while length != 0
      if !yield(first)
        output = false
        break
      else
        shift
      end
    end
    output
  end
end

[5, 5, 5, 5, 5, 5].my_all? { |el| el == 5 }
