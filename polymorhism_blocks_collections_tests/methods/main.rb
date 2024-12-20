require_relative 'arrayprocessor'
def main
  processor = Arrayprocessor.new([1, 3, 5, 2, 4])

  puts "Элементы массива: #{processor.elements}"
  puts "Чанк по четности: #{processor.chunk { |n| n.even? }.to_a}"
  puts "Включает 3? #{processor.include?(3)}"
  puts "Сумма всех элементов: #{processor.sum}"
  puts "Член массива 10? #{processor.member?(10)}"
  puts "Фильтр элементов больше 3: #{processor.filter { |n| n > 3 }}"
  puts "Сумма элементов с reduce: #{processor.reduce(0) { |sum, n| sum + n }}"
end
main

