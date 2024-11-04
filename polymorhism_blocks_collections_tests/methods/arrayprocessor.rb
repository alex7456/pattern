class ArrayProcessor
def initialize(array)
	@array = array.dup.freeze
end
def elements
@array.dup
end
def chunk
result =[]
chunk=[]
 @array.each do |item|
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
@array.each do |item|
return true if item==value 
end
false
end
def reduce(initial = nil)
    accumulator = initial
    @array.each do |item|
      accumulator = accumulator.nil? ? item : yield(accumulator, item)
    end
    accumulator
  end