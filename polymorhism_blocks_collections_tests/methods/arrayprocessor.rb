class ArrayProcessor
  attr_reader :array
  def initialize(array)
    @array = array
  end
  def elements
    array.dup
  end
  def chunk
    chunk = []
    result = []
    array.each do |item|
      if chunk.empty? || yield(chunk.last) == yield(item)
        chunk << item
      else
        result << chunk
        chunk = [item]
      end
    end
    result << chunk unless chunk.empty?
    result
  end
  def include?(value)
    array.each do |item|
      return true if item == value
    end
  end
  false
  def reduce(initial = nil)
    accumulator = initial
    array.each do |item|
      if accumulator.nil?
        accumulator = item
      else
        accumulator = yield(accumulator, item)
      end


    end
    accumulator
  end
  def sum
    total = 0
    array.each do |item|
      total += item
    end
    total
  end
  def member?(value)
    array.each do |item|
      return true if item == value
    end
    false
  end
  def filter
    result = []
    array.each do |item|
      result << item if yield(item)
    end
    result
  end
end
