
def count_even_non_coprimes(n)
  count = 0
  (1..n).each do |i|
    if i.even? && i.gcd(n) != 1
      count += 1
    end
  end
  count
end

number = 12
puts "Количество чётных чисел, не взаимно простых с числом #{number}: #{count_even_non_coprimes(number)}"

def max_digit_not_divisible_by_3(n)
  digits = n.to_s.chars.map(&:to_i)
  digits.reject { |digit| digit % 3 == 0 }.max
end

number = 923456
puts "Максимальная цифра числа #{number}, не делящаяся на 3: #{max_digit_not_divisible_by_3(number)}"

def smallest_divisor(n)
  (2..n).each { |i| return i if n % i == 0 }
end

def max_non_coprime_not_divisible(n)
  min_div = smallest_divisor(n)
  max_non_coprime = (1...n).select { |i| i.gcd(n) != 1 && i % min_div != 0 }.max
  max_non_coprime
end

def sum_digits_less_than_5(n)
  n.to_s.chars.map(&:to_i).select { |digit| digit < 5 }.sum
end

def product_of_max_and_sum(n)
  max_non_coprime = max_non_coprime_not_divisible(n)
  sum_digits = sum_digits_less_than_5(n)
  max_non_coprime * sum_digits
end

number = 36
puts "Произведение: #{product_of_max_and_sum(number)}"
