 #1. Убывающая последовательность индексов
def descending_indices(data, input_type)
  array = get_array_input(data, input_type)
  result = array.each_with_index.sort_by { |val, index| -val }.map { |val, index| index }
  puts "Индексы в порядке убывания значений: #{result}"
end
# 2. Элементы между первым и вторым максимальными
def elements_between_first_and_second_max(data, input_type)
  array = get_array_input(data, input_type)
  max1, max2 = array.max(2)

  idx1 = array.index(max1)  # Индекс первого максимального
  idx2 = array.rindex(max2) # Индекс второго максимального
  
  if idx1 && idx2 && idx2 > idx1
    puts "Элементы между первым и вторым максимальными: #{array[(idx1 + 1)...idx2]}"
  else
    puts "Невозможно найти элементы между первым и вторым максимальными, так как они расположены в некорректном порядке."
  end
end

# Вспомогательные методы для получения ввода
def get_array_input(data, input_type)
  if input_type == :keyboard
    puts "Введите элементы массива через пробел:"
    gets.chomp.split.map(&:to_i)
  else
    data # Если данные были из файла, они уже переданы
  end
end
