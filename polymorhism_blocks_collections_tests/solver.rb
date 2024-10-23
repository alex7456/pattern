 #1. Убывающая последовательность индексов
def descending_indices(data, input_type)
  array = get_array_input(data, input_type)
  result = array.each_with_index.sort_by { |val, index| -val }.map { |val, index| index }
  puts "Индексы в порядке убывания значений: #{result}"
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
