class Arrayprocessor
  attr_reader :array
  def initialize(array)
    @array = array
  end
  def elements
    array.dup
  end
  def chunk
    result = []
    chunk = []
    current_key = nil

    array.each do |item|
      key = yield(item)
      if chunk.empty? || current_key == key
        chunk << item
      else
        result << [current_key, chunk]
        chunk = [item]
      end
      current_key = key
    end

    result << [current_key, chunk] unless chunk.empty?
    result
  end

  def include?(value)
    array.each do |item|
      return true if item == value
    end
    false
  end
  def sum
    total = 0
    array.each do |item|
      total += item
    end
    total
  end
  def reduce(initial = nil)
    accumulator = initial
    array.each do |item|
      if accumulator.nil?
        accumulator = item
      else
        accumulator=yield(accumulator, item)
      end

    end
    accumulator
  end
  def filter
    result=[]
    array.each do |item|
      result << item if yield(item)
    end
    result
  end
def member?(value)
    array.each do |item|
      return true if item == value
    end
    false
  end
