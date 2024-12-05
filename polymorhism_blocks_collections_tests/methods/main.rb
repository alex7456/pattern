require_relative 'ArrayProcessor'
def main
  processor = ArrayProcessor.new([1, 2, 3, 4, 5])

  puts "Элементы массива: #{processor.elements}"
  puts "Чанк по четности: #{processor.chunk { |n| n.even? }}"
  puts "Включает 3? #{processor.include?(3)}"
  puts "Сумма всех элементов: #{processor.sum}"
  puts "Член массива 10? #{processor.member?(10)}"
  puts "Фильтр элементов больше 3: #{processor.filter { |n| n > 3 }}"
  puts "Сумма элементов с reduce: #{processor.reduce(0) { |sum, n| sum + n }}"
end
main
