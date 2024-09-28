
def find_min(array)
  min_element = array[0]
  for i in 1...array.length
    if array[i] < min_element
      min_element = array[i]
    end
  end
  min_element
end


def find_first_positive_index(array)
  first_positive_index = -1
  i = 0
  while i < array.length
    if array[i] > 0
      first_positive_index = i
      break
    end
    i += 1
  end
  first_positive_index
end


operation = ARGV[0]
file_path = ARGV[1]


array = File.read(file_path).split.map(&:to_i)


case operation
when 'min'
  min_element = find_min(array)
  puts "Минимальный элемент: #{min_element}"

when 'pos'
  first_positive_index = find_first_positive_index(array)
  puts "Номер первого положительного элемента: #{first_positive_index}"

else
  puts "Неизвестная операция! Используйте 'min' или 'pos'."
end
