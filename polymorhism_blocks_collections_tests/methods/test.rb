require_relative 'ArrayProcessor'

def test_elements
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  raise "Test elements failed" unless processor.elements == [1, 2, 3, 4, 5]
end

def test_chunk
  processor = ArrayProcessor.new([1, 2, 2, 3, 3, 4])
  result = processor.chunk { |n| n.even? }
  expected = [[1], [2, 2], [3, 3], [4]]
  raise "Test chunk failed" unless result == expected
end

def test_include?
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  raise "Test include? with 3 failed" unless processor.include?(3) == true
  raise "Test include? with 6 failed" unless processor.include?(6) == false
end

def test_reduce
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  result = processor.reduce(0) { |sum, n| sum + n }
  expected = 15
  raise "Test reduce failed" unless result == expected
end

def test_sum
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  result = processor.sum
  expected = 15
  raise "Test sum failed" unless result == expected
end

def test_member?
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  raise "Test member? with 4 failed" unless processor.member?(4) == true
  raise "Test member? with 10 failed" unless processor.member?(10) == false
end

def test_filter
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  result = processor.filter { |n| n > 3 }
  expected = [4, 5]
  raise "Test filter failed" unless result == expected
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
  puts "All tests passed" # Только для финального результата, можно убрать, если нужен строгий запрет на `puts`
end

# Выполнение тестов
run_tests
