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

  def my_all?(inp = nil)
    output = true

    if inp
      my_each { |el| !(el.class.ancestors.include? inp) && (return output = false) }
    else
      my_each { |el| !yield(el) && (return output = false) }
    end

    output
  end

  # ############################################################################

  # ***************************     my_any     *********************************

  # ############################################################################

  def my_any?(arg = nil)
    output = false

    if !arg

      if block_given?
        # checking if there is no argument but there is block
        output = true unless my_select { |el| yield(el) }.empty?
      else
        # checking if argument is empty and array is empty returning true
        output = !to_a.empty?
        filtered_array = my_select { |el| el.nil? || el == false }
        output = false if filtered_array.include? nil
        output = false if filtered_array.include? false
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
    output = true

    if !arg

      if block_given?
        # checking if there is no argument but there is block
        output = false unless my_select { |el| yield(el) }.empty?
      else
        # checking if argument is empty and array is empty returning true
        output = to_a.empty? ? true : false
      end

    elsif arg.is_a?(Class)
      # if argument is not empty then checking if arg is Class or object value
      output = false unless my_select { |el| el.class <= arg }.empty?
    else
      output = false unless my_select { |el| el == arg }.empty?
    end

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
