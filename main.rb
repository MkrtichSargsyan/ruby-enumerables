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

#  k = {2 => '23435',3 => '23dfgdf435'}.select { |el| el == 2}
#  p k
#  d = {2 => '23435',3 => '23dfgdf435'}.my_select { |el|  el == 2}
#  p d

#  k = [3,4,5,6,7].select { |el|  el <5}
#  p k
#  d = [3,4,5,6,7].my_select { |el| el < 5}
#  p d

# k = (1..5).select { |el|  el >3 }
# p k
# d = (1..5).my_select { |el|  el > 3}
# p d
