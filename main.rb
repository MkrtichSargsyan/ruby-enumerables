module Enumerable
  # ############################################################################

  # ***************************     my_each     ********************************

  # ############################################################################

  def my_each
    return to_enum(:my_each) unless block_given?

    ind = 0

    while ind != to_a.length
      yield to_a[ind]
      ind += 1
    end

    self
  end

  # ############################################################################

  # ***********************     my_each_with_endex     *************************

  # ############################################################################

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0

    my_each do |el|
      yield(el, index)
      index += 1
    end

    self
  end

  # ############################################################################

  # ***************************     my_select     ******************************

  # ############################################################################

  def my_select
    return to_enum(:my_select) unless block_given?

    filtered = []

    if self.class == Hash
      filtered = {}

      my_each do |el|
        key = el [0]
        value = el [1]
        filtered [key] = value if yield(el[0])
      end

      filtered

    else

      filtered = []

      my_each do |el|
        filtered.push(el) if yield(el)
      end
    end

    filtered
  end

  # ############################################################################

  # ***************************     my_all     *********************************

  # ############################################################################

  def my_all?(arg = nil)
    output = false

    if !arg # no arguments

      filtered_array = block_given? ? my_select { |el| yield(el) } : my_select { |el| el}

    elsif arg.is_a?(Class)
      # if argument is not empty then checking if arg is Class or object value
      filtered_array = my_select { |el| el.class <= arg}
    else
      filtered_array = my_select { |el| el == arg }
    end
    output = true if filtered_array==self.to_a
    output
  end

  # ############################################################################

  # ***************************     my_any     *********************************

  # ############################################################################

  def my_any?(arg = nil)
    output = false

    if !arg # no arguments

      if block_given? # given block
        output = true unless my_select { |el| yield(el) }.empty?
      else 
        filtered_array = my_select { |el| el}
        output = filtered_array.empty? ?  false : true
      end

    elsif arg.is_a?(Class)
      # if argument is not empty then checking if arg is Class or object value
      output = true unless my_select { |el| el.class <= arg }.empty?
    else
      output = true unless my_select { |el| el == arg }.empty?
    end

    output
  end

  # ############################################################################

  # ***************************     my_none     ********************************

  # ############################################################################

  def my_none?(arg = nil)
    output = false

    if !arg

      filtered_array = block_given? ? my_select { |el| yield(el) } : my_select { |el| el}

    elsif arg.is_a?(Class)
      filtered_array = my_select { |el| el.class <= arg }
    else
      filtered_array = my_select { |el| el == arg }
    end

    output = true if filtered_array.empty?
    output
  end

  # ############################################################################

  # ***************************     my_count     *******************************

  # ############################################################################

  def my_count(num = nil)
    if num
      selected = my_select { |el| el == num }
      selected.length
    else
      return to_a.length unless block_given?

      count = 0

      my_each do |el|
        yield(el) && count += 1
      end
      count
    end
  end

  # ############################################################################

  # ***************************     my_map     *********************************

  # ############################################################################

  def my_map(proc_block = nil)
    return to_enum(:my_map) unless block_given?

    new_arr = []

    if proc_block.class == Proc and block_given?
      my_each { |el| new_arr.push(proc_block.call(el)) }
    else
      my_each { |el| new_arr.push(yield(el)) }
    end

    new_arr
  end

  # ############################################################################

  # ***************************     my_inject     ******************************

  # ############################################################################

  def my_inject(num = nil)
    raise LocalJumpError, 'no block given' unless block_given?

    type = self[0].class

    if num.nil?
      num = type == String ? '' : 0
    end

    output = num.class == Float || Integer ? num : num.to_s

    my_each do |sum|
      output = yield(output, sum)
    end

    output
  end
end

# ############################################################################

# ***************************     multiply_els    ****************************

# ############################################################################

def multiply_els(arr)
  arr.my_inject(1) { |acc, sum| acc * sum }
end


puts [3,3].none?
puts [3,3].my_none?


