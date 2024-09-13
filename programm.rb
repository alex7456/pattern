operation = ARGV[0]
file_path = ARGV[1]

array = File.read('input.txt').split.map(&:to_i)


case operation
when 'min'
min_element = array[0]
for i in 1...array.length
if array[i] < min_element
min_element = array[i]
end
end
puts "Минимальный элемент : #{min_element}"
when 'pos'
first_positive_index = -1
i=0
while i < array.length
if array[i] > 0
first_positive_index=i
break
end
i+=1
end
puts "Номер первого положительного элемента : #{first_positive_index}"
end