def find_min(arr)
  min = arr[0]
  for i in 1...arr.length
    if arr[i] < min
      min = arr[i]
    end
  end
  min
end

def find_first_positive_index(arr)
  index = -1
  i = 0
  while i < arr.length
    if arr[i] > 0
      index = i
      break
    end
    i += 1
  end
  index
end
array = [-3, -1, 0, 4, -5, 2]

min_element = find_min(array)
first_positive_index = find_first_positive_index(array)

puts "Минимальный элемент: #{min_element}"
puts "Номер первого положительного элемента: #{first_positive_index}"
