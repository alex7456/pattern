require_relative 'ArrayProcessor'

def test_elements
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  puts "Test elements: #{processor.elements == [1, 2, 3, 4, 5]}"
end

def test_chunk
  processor = ArrayProcessor.new([1, 2, 2, 3, 3, 4])
  result = processor.chunk { |n| n.even? }
  expected = [[1], [2, 2], [3, 3], [4]]
  puts "Test chunk: #{result == expected}"
end

def test_include?
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  puts "Test include? with 3: #{processor.include?(3) == true}"
  puts "Test include? with 6: #{processor.include?(6) == false}"
end

def test_reduce
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  result = processor.reduce(0) { |sum, n| sum + n }
  expected = 15
  puts "Test reduce: #{result == expected}"
end

def test_sum
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  result = processor.sum
  expected = 15
  puts "Test sum: #{result == expected}"
end

def test_member?
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  puts "Test member? with 4: #{processor.member?(4) == true}"
  puts "Test member? with 10: #{processor.member?(10) == false}"
end

def test_filter
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  result = processor.filter { |n| n > 3 }
  expected = [4, 5]
  puts "Test filter: #{result == expected}"
end

# Запуск всех тестов
def run_tests
  test_elements
  test_chunk
  test_include?
  test_reduce
  test_sum
  test_member?
  test_filter
end

# Выполнение тестов
run_tests
