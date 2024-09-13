puts 'Введите число:'
number = gets.chomp.to_i
count = 0
(1..number).each do |i|
if i.even? && i.gcd(number)!=1
count+=1
end
end
puts "Количество чётных чисел, не взаимно простых с числом #{number}: #{count}"

puts 'Введите число:'
number = gets.chomp.to_i
digits = number.to_s.chars.map(&:to_i)
max_digit = digits.reject { |digit| digit % 3 == 0 }.max
puts "Максимальная цифра числа #{number}, не делящаяся на 3: #{max_digit}"


