require 'json'
require 'yaml'
require_relative 'Student'
require_relative 'Student_short'
require_relative 'student_tree'
require_relative 'DataList/data_table'
require_relative 'DataList/data_list'
require_relative 'DataList/data_list_student_short'
require_relative 'Human'
require_relative 'student_list_json'
require_relative 'student_list_yaml'
student1 = Student.new(first_name: "Иван", surname: "Иванов", last_name: "Иванович", birthdate: "2000-05-15")
student2 = Student.new(first_name: "Петр", surname: "Петров", last_name: "Петрович",birthdate: "1998-08-20")
student3 = Student.new(first_name: "Алексей", surname: "Алексеев", last_name: "Алексеевич", birthdate: "2002-03-10")
student4 = Student.new(first_name: "Мария", surname: "Сидорова", last_name: "Александровна", birthdate: "1997-12-31")
tree = StudentTree.new
tree.add(student1)
tree.add(student2)
tree.add(student3)
tree.add(student4)
puts "Все студенты в порядке даты рождения:"
tree.each { |student| puts "#{student.surname} #{student.birthdate}" }
filtr_students=tree.select{|student| student.birthdate > "1997-12-31"}
filtr_students.each {|student| puts student}

# Создание студентов
studentshort1=Student_short.from_student(student)
studentshort3=Student_short.from_string(string)
list_student_short = Data_list_student_short.new([studentshort1, studentshort3])
# Тестируем выбор студентов
list_student_short.select(0)
puts "Выбранные: #{list_student_short.get_selected}"

list_student_short.select(1)
puts "Выбранные: #{list_student_short.get_selected}"


puts list_student_short.get_names
# Получаем данные
puts "Таблица выбранных студентов:"
table = list_student_short.get_data
puts table.to_s

# Создаем файл JSON для тестирования
TEST_JSON_FILE = 'students_test.json'

# Создаем тестовый JSON-файл, если он не существует
unless File.exist?(TEST_JSON_FILE)
  test_data = [
    {
      id: 1,
      first_name: "Иван",
      last_name: "Иванов",
      surname: "Иванович",
      phone: "111-222-333",
      telegram: "@ivanov",
      email: "ivanov@ya.ru",
      git: "https://github.com/ivanov",
      birthdate: "2000-05-15"
    },
    {
      id: 2,
      first_name: "Петр",
      last_name: "Петров",
      surname: "Петрович",
      phone: "222-333-444",
      telegram: "@petrov",
      email: "petrov@ya.ru",
      git: "https://github.com/petrov",
      birthdate: "1998-08-20"
    }
  ]
  File.write(TEST_JSON_FILE, JSON.pretty_generate(test_data))
end

# Создаем объект для работы с JSON
students_list = StudentsListJSON.new(TEST_JSON_FILE)

# Загружаем и выводим список студентов
puts "Загруженные студенты:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Добавляем нового студента
puts "\nДобавляем нового студента:"
new_student = Student.new(
  first_name: "Мария",
  last_name: "Сидорова",
  surname: "Александровна",
  phone: "333-444-555",
  telegram: "@sidorova",
  email: "sidorova@ya.ru",
  git: "https://github.com/sidorova",
  birthdate: "1997-12-31"
)
students_list.add_student(new_student)

# Вывод списка студентов после добавления
puts "\nСписок студентов после добавления нового:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Удаляем студента по ID
puts "\nУдаляем студента с ID 2:"
students_list.delete_by_id(2)

# Вывод списка студентов после удаления
puts "\nСписок студентов после удаления:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Сортировка студентов по фамилии и инициалам
puts "\nСортируем студентов по фамилии и инициалам:"
students_list.sort_by_initials!

# Вывод отсортированного списка
puts "\nСписок студентов после сортировки:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Получение короткого списка
puts "\nПолучение короткого списка студентов (первые 2 записи):"
short_list = students_list.get_k_n_student_short_list(1, 2)
puts short_list.get_data.to_s

# Сохраняем изменения в файл
students_list.save_to_file
puts "\nИзменения сохранены в файл '#{TEST_JSON_FILE}'."

TEST_YAML_FILE = 'students_test.yaml'

# Создаем тестовый JSON-файл, если он не существует
unless File.exist?(TEST_YAML_FILE)
  test_data = [
    {
      id: 1,
      first_name: "Иван",
      last_name: "Иванов",
      surname: "Иванович",
      phone: "111-222-333",
      telegram: "@ivanov",
      email: "ivanov@ya.ru",
      git: "https://github.com/ivanov",
      birthdate: "2000-05-15"
    },
    {
      id: 2,
      first_name: "Петр",
      last_name: "Петров",
      surname: "Петрович",
      phone: "222-333-444",
      telegram: "@petrov",
      email: "petrov@ya.ru",
      git: "https://github.com/petrov",
      birthdate: "1998-08-20"
    }
  ]
  File.write(TEST_YAML_FILE, YAML.dump(test_data))
end

# Создаем объект для работы с JSON
students_list = StudentsListYAML.new(TEST_YAML_FILE)

# Загружаем и выводим список студентов
puts "Загруженные студенты:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Добавляем нового студента
puts "\nДобавляем нового студента:"
new_student = Student.new(
  first_name: "Мария",
  last_name: "Сидорова",
  surname: "Александровна",
  phone: "333-444-555",
  telegram: "@sidorova",
  email: "sidorova@ya.ru",
  git: "https://github.com/sidorova",
  birthdate: "1997-12-31"
)
students_list.add_student(new_student)

# Вывод списка студентов после добавления
puts "\nСписок студентов после добавления нового:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Удаляем студента по ID
puts "\nУдаляем студента с ID 2:"
students_list.delete_by_id(2)

# Вывод списка студентов после удаления
puts "\nСписок студентов после удаления:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Сортировка студентов по фамилии и инициалам
puts "\nСортируем студентов по фамилии и инициалам:"
students_list.sort_by_initials!

# Вывод отсортированного списка
puts "\nСписок студентов после сортировки:"
students_list.count.times do |i|
  student = students_list.find_by_id(i + 1)
  puts student
end

# Получение короткого списка
puts "\nПолучение короткого списка студентов (первые 2 записи):"
short_list = students_list.get_k_n_student_short_list(1, 2)
puts short_list.get_data.to_s

# Сохраняем изменения в файл
students_list.save_to_file
puts "\nИзменения сохранены в файл '#{TEST_YAML_FILE}'."


