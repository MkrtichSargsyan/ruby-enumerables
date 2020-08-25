module Enumerable
  # my-each

  def my_each
    return to_enum unless block_given?

    ind = 0

    while ind != self.to_a.length
      yield self.to_a[ind]
      ind += 1
    end

    self.to_a
  end

  # my_each_with_index

  def my_each_with_index
    index = 0
    my_each do |el|
      yield(el, index)
      index += 1
    end

    self
  end

  # my_select

  def my_select
    filtered_arr = []

    while length != 0
      yield(first) && filtered_arr.push(first)
      shift
    end

    filtered_arr
  end

  # my_all

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

  # my_any

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

  # my_none

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

  # my_count

  def my_count
    count = 0

    my_each do |el|
      yield(el) && count += 1
    end
    count
  end

  # my_map

  def my_map(&proc_block)
    new_arr = []

    my_each { |el| new_arr.push(proc_block.call(el)) }

    new_arr
  end

  # my_inject

  def my_inject(num)
    output = num

    my_each do |sum|
      output = yield(output, sum)
    end
    output
  end
end

# multiply_els

def multiply_els(arr)
  arr.my_inject(1) { |acc, sum| acc * sum }
end

{"1" => "January", "2" => "February"}.my_each {|el| puts el}
# puts (0..5)[2]