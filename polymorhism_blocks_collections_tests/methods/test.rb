require 'minitest/autorun'
require_relative './arrayprocessor'

class TestArrayProcessor < Minitest::Test
  def test_elements
    processor = Arrayprocessor.new([1, 2, 3, 4, 5])
    assert_equal [1, 2, 3, 4, 5], processor.elements
  end

  def test_chunk
    processor = Arrayprocessor.new([1, 2, 2, 3, 3, 4])
    result = processor.chunk { |n| n.even? }
    expected = [[1], [2, 2], [3, 3], [4]]
    assert_equal expected, result
  end

  def test_include?
    processor = Arrayprocessor.new([1, 2, 3, 4, 5])
    assert processor.include?(3)
    refute processor.include?(6)
  end

  def test_reduce
    processor = Arrayprocessor.new([1, 2, 3, 4, 5])
    result = processor.reduce(0) { |sum, n| sum + n }
    expected = 15
    assert_equal expected, result
  end

  def test_sum
    processor = Arrayprocessor.new([1, 2, 3, 4, 5])
    result = processor.sum
    expected = 15
    assert_equal expected, result
  end

  def test_member?
    processor = Arrayprocessor.new([1, 2, 3, 4, 5])
    assert processor.member?(4)
    refute processor.member?(10)
  end

  def test_filter
    processor = Arrayprocessor.new([1, 2, 3, 4, 5])
    result = processor.filter { |n| n > 3 }
    expected = [4, 5]
    assert_equal expected, result
  end
end
