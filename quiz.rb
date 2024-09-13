
username = ARGV[0]


puts "Привет, #{username}!"


puts "Какой твой любимый язык программирования?"
favorite_language = gets.chomp.downcase


if favorite_language == "ruby"
  puts "Ого, #{username}, ты подлиза!"
else
  puts "Не переживай, скоро будет Ruby!"
  
  case favorite_language
  when "python"
    puts "хороший выбор"
  when "javascript"
    puts "JavaScript — отличный язык для веб-разработки."
  when "c++"
    puts "..."
  
  end
end
puts 'Введите команду на языке Ruby :'
ruby_command = gets.chomp
puts 'Результат выполнения команды Ruby:'
eval(ruby_command)

puts 'Введите команду для операционной системы'
os_command = gets.chomp
puts 'Результат выполнения команды ОС'
system(os_command)