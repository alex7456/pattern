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
def elements_between_first_and_last_max(data, input_type)
  array = get_array_input(data, input_type)
  max_val = array.max
  idx1 = array.index(max_val)
  idx2 = array.rindex(max_val)
  if idx1 && idx2 && idx1 != idx2
    puts "Элементы между первым и последним максимальными: #{array[(idx1+1)...idx2]}"
  else
    puts "Максимальные элементы находятся в одном месте"
  end
end
# 3. Элементы между первым и последним максимальными
def elements_between_first_and_last_max(data, input_type)
  array = get_array_input(data, input_type)
  max_val = array.max
  idx1 = array.index(max_val)
  idx2 = array.rindex(max_val)
  if idx1 && idx2 && idx1 != idx2
    puts "Элементы между первым и последним максимальными: #{array[(idx1+1)...idx2]}"
  else
    puts "Максимальные элементы находятся в одном месте"
  end
end
# 4. Найти минимальный четный элемент
def find_min_even(data, input_type)
  array = get_array_input(data, input_type)
  min_even = array.select(&:even?).min
  if min_even
    puts "Минимальный четный элемент: #{min_even}"
  else
    puts "Четных элементов нет"
  end
end
# 5. Построить список простых делителей числа
def prime_factors(data, input_type)
  number = get_number_input(data, input_type)
  factors = []
  factorize(number) do |prime_factor|
    factors << prime_factor
  end
  puts "Простые делители числа: #{factors.sort}"
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
def get_number_input(data, input_type)
  if input_type == :keyboard
    puts "Введите число:"
    gets.chomp.to_i
  else
    data.first # Если данные из файла, берем первое число
  end
end

def factorize(n, &block)
  factor = 2
  while n > 1
    while n % factor == 0
      yield factor
      n /= factor
    end
    factor += 1
  end
end
