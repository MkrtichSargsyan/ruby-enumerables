module Enumerable
  # my-each

  def my_each
    return to_enum(:my_each) unless block_given?

    ind = 0

    while ind != to_a.length
      yield to_a[ind]
      ind += 1
    end

    self
  end

  # my_each_with_index

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0

    my_each do |el|
      yield(el, index)
      index += 1
    end

    self
  end

  # my_select

  def my_select
    return to_enum(:my_select) unless block_given?

    filtered=[]

    if self.class == Hash
      filtered = {}

      my_each do |el|
        key = el [0]
        value = el [1]
        # p "key = #{key}"
        # p "value = #{value}"
  
        if yield(el[0]) 
        
            filtered [key] = value
        end 
      end

      filtered

      else

        filtered = [] 

        my_each do |el|
          if yield(el) 
          
              filtered.push(el)
          end 
        end
    end

    filtered
  end

  # my_all

  def my_all?
    # return false unless block_given?
    if !block_given?
      return false
    end
    output = true

    my_each do |el|
      if !yield(el)
        output = false
        break
      end
    end

    # while length != 0
    #   if !yield(first)
    #     output = false
    #     break
    #   else
    #     shift
    #   end
    # end
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

  # my_map

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

  # my_inject

  def my_inject(num = 0)
    raise LocalJumpError.new "no block given" unless block_given?


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

#  k = {2 => '23435',3 => '23dfgdf435'}.count
#  p k
#  d = {2 => '23435',3 => '23dfgdf435'}.my_count
#  p d

#  k = [1,2,3,4,5,6,7,5].count {|el| el == 5}
#  p k 
#  d = [1,2,3,4,5,6,5,7,5].my_count {|el| el == 5}
#  p d

# k = (1..5).count(2) {|el| el == 5}
# p k
# d = (1..5).my_count(2) {|el| el == 5}
# p d

p = Proc.new{|el| el*2}

# puts [2,4,5].inject 
puts (1..5).my_inject(1) {|acc, el| acc *= el}