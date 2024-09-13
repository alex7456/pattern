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

puts 'Введите число:'
number = gets.chomp.to_i
smallest_div = (2..number).find { |i| number % i == 0 }
max_non_coprime = (1...number).select { |i| i.gcd(number) != 1 && i % smallest_div != 0 }.max
sum_digits_less_than_5 = number.to_s.chars.map(&:to_i).select { |digit| digit < 5 }.sum
product = max_non_coprime * sum_digits_less_than_5
puts "Произведение максимального числа, не взаимно простого с #{number}, и суммы цифр, меньших 5: #{product}"

