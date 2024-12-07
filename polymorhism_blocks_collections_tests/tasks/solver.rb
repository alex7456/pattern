# Индексы элементов в порядке убывания значений
def descending_indices(arr)
  arr.each_with_index.sort_by { |x, _| -x }.map { |_, i| i }
end

# Элементы между первым и вторым максимальным
def between_first_and_second_max(arr)
  max_indices = arr.each_index.select { |i| arr[i] == arr.max }
  return [] if max_indices.size < 2

  arr[(max_indices[0] + 1)...max_indices[1]]
end

# Элементы между первым и последним максимальным
def between_first_and_last_max(arr)
  max_indices = arr.each_index.select { |i| arr[i] == arr.max }
  return [] if max_indices.size < 2

  arr[(max_indices.first + 1)...max_indices.last]
end

# Минимальный четный элемент
def min_even(arr)
  evens = arr.select(&:even?)
  evens.min || "Нет четных элементов"
end

# Список простых делителей числа
def prime_factors(n)
  factors = []
  divisor = 2
  while n > 1
    while (n % divisor).zero?
      factors << divisor
      n /= divisor
    end
    divisor += 1
    break if divisor * divisor > n
  end
  factors << n if n > 1
  factors
end

loop do
  puts "Выберите, что нужно выполнить:"
  puts "1. Вывести индексы массива в порядке убывания элементов"
  puts "2. Найти элементы между первым и вторым максимальным"
  puts "3. Найти элементы между первым и последним максимальным"
  puts "4. Найти минимальный четный элемент"
  puts "5. Построить список всех простых делителей числа"
  puts "0. Выход"
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Введите элементы массива через пробел"
    arr = gets.chomp.split.map(&:to_i)
    puts "Индексы в порядке убывания: #{descending_indices(arr)}"
  when 2
    puts "Введите элементы массива через пробел"
    arr = gets.chomp.split.map(&:to_i)
    puts "Элементы между первым и вторым максимальным: #{between_first_and_second_max(arr)}"
  when 3
    puts "Введите элементы массива через пробел"
    arr = gets.chomp.split.map(&:to_i)
    puts "Элементы между первым и последним максимальным: #{between_first_and_last_max(arr)}"
  when 4
    puts "Введите элементы массива через пробел"
    arr = gets.chomp.split.map(&:to_i)
    puts "Минимальный четный элемент: #{min_even(arr)}"
  when 5
    puts "Введите число"
    n = gets.chomp.to_i
    puts "Простые делители числа: #{prime_factors(n)}"
  when 0
    puts "Завершение программы"
    break
  else
    puts "Неправильное значение"
  end
end
