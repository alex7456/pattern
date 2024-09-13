puts 'Введите число:'
number = gets.chomp.to_i
count = 0
(1..number).each do |i|
if i.even? && i.gcd(number)!=1
count+=1
end
end
puts "Количество чётных чисел, не взаимно простых с числом #{number}: #{count}"



