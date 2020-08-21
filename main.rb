module Enumerable
  def my_each
    each { |el| yield el }
  end
end

[1, 2, 6].my_each { |el| puts el }
