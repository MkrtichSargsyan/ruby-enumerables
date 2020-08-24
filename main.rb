module Enumerable
  def my_each
    ind = 0

    while ind != length
      yield self[ind]
      ind += 1
    end
  end

  def my_each_with_index
    index = 0
    my_each do |el|
      yield(el, index)
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

  def my_any?
    output = false
    my_each do |el|
      if yield el
        output = true
        break
      end
    end
    output
  end

  def my_none?
    output = true

    while length != 0
      if yield first
        output = false
        break
      else
        shift
      end
    end
    output
  end

  def my_count
    count = 0

    my_each do |el|
      yield(el) && count += 1
    end
    count
  end

  # def my_map
  #   new_arr = []

  #   my_each do |el|
  #     new_arr.push(yield(el))
  #   end

  #   new_arr
  # end

  def my_map(&proc_block)
    new_arr = []

    my_each do |el|
      new_arr.push(proc_block.call(el))
    end

    new_arr
  end

  def my_inject(num)
    output = num

    my_each do |sum|
      output = yield(output, sum)
    end
    output
  end

end

def multiply_els(arr)
  arr.my_inject(1) {|acc, sum| acc * sum}
end

p = Proc.new { |el| el * 3 }

# p multiply_els([2,4,5])
puts [4, 2, 3].my_map { |el| el * 3 }
