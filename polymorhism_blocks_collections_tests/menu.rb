require_relative 'solver'
def main
  input_type = nil
  data = nil
  
  puts "Выберите способ ввода данных: "
  puts "1. С клавиатуры"
  puts "2. Из файла"

  input_choice = gets.chomp.to_i
  case input_choice
  when 1
    input_type = :keyboard
    # При выборе с клавиатуры, данные будут введены позже в задачах
  when 2
    input_type = :file
    puts "Введите путь к файлу с данными:"
    file_path = gets.chomp
    data = read_data_from_file(file_path) # Чтение данных из файла
  else
    puts "Некорректный выбор"
    return
  end

  puts "Выберите задачу: "
  puts "1. Убывающая последовательность индексов"
   puts "2. Элементы между первым и вторым максимальными"
  puts "3. Элементы между первым и последним максимальными"
  puts "4. Минимальный четный элемент"
  puts "5.Построить список простых делителей числа"
  choice = gets.chomp.to_i

  # Передаем прочитанные данные в зависимости от выбора задачи
  case choice
  when 1
    descending_indices(data, input_type)
	when 2
	    elements_between_first_and_second_max(data, input_type)
  when 3
  elements_between_first_and_last_max(data,input_type)
  when 4
  find_min_even(data,input_type)
  when 5
  prime_factors(data,input_type)
	end
	end
	
	# Метод для чтения данных из файла
def read_data_from_file(file_path)
  if File.exist?(file_path)
    data = File.read(file_path).split.map(&:to_i) # Чтение массива чисел из файла
    data
  else
    puts "Файл не найден"
    exit
  end
end
main
