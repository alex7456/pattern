array = [-3, -1, 0, 4, -5, 2]


min_element = array[0]
for i in 1...array.length
  if array[i] < min_element
    min_element = array[i]
  end
end


first_positive_index = -1
i = 0
while i < array.length
  if array[i] > 0
    first_positive_index = i
    break
  end
  i += 1
end

puts "Минимальный элемент: #{min_element}"
puts "Номер первого положительного элемента: #{first_positive_index}"
