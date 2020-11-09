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

    filtered_array = if !arg # no arguments

                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       # if argument is not empty then checking if arg is Class or object value
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true if filtered_array == to_a
    output
  end

  # ############################################################################

  # ***************************     my_any     *********************************

  # ############################################################################

  def my_any?(arg = nil)
    output = false

    filtered_array = if !arg # no arguments

                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       # if argument is not empty then checking if arg is Class or object value
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true unless filtered_array.to_a.empty?
    output
  end

  # ############################################################################

  # ***************************     my_none     ********************************

  # ############################################################################

  def my_none?(arg = nil)
    output = false

    filtered_array = if !arg

                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end

    output = true if filtered_array.to_a.empty?
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

  def my_inject(arg = nil, symb = nil)
    output = ''

    # if block_given?

    if arg.class <= Symbol || (symb.class <= Symbol and arg) # checking if one of arguments is symbol

      if symb.nil?

        ind = 1
        output = to_a[0]
        while ind < to_a.length
          output = output.send(arg, to_a[ind])
          ind += 1
        end
      else
        output = arg
        my_each { |el| output = output.send(symb, el) }
      end

    elsif block_given?

      if arg # checking if block has default value
        output = arg
        to_a.my_each { |el| output = yield(output, el) }
      else

        ind = 1
        output = to_a[0]
        while ind < to_a.length
          output = yield(output, to_a[ind])
          ind += 1
        end
      end

    else
      raise LocalJumpError, 'no block given'
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

p Range.new(1, 4).my_inject(-10, :/)
p Range.new(1, 4).inject(-10, :/)
