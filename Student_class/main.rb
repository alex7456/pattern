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
require_relative 'StudentsListBase'
require_relative 'JSONStrategy'
require_relative 'YAMLStrategy'
require_relative 'file_strategy'
# Создаем тестовые данные студентов
student1 = Student.new(first_name: "Иван", surname: "Иванов", last_name: "Иванович", birthdate: "2000-05-15")
student2 = Student.new(first_name: "Петр", surname: "Петров", last_name: "Петрович", birthdate: "1998-08-20")
student3 = Student.new(first_name: "Алексей", surname: "Алексеев", last_name: "Алексеевич", birthdate: "2002-03-10")
student4 = Student.new(first_name: "Мария", surname: "Сидорова", last_name: "Александровна", birthdate: "1997-12-31")

# Создаем дерево студентов для сортировки
tree = StudentTree.new
tree.add(student1)
tree.add(student2)
tree.add(student3)
tree.add(student4)

puts "Все студенты в порядке даты рождения:"
tree.each { |student| puts "#{student.surname} #{student.birthdate}" }

# Фильтруем студентов по дате рождения
puts "\nСтуденты, рожденные после 1997-12-31:"
filtr_students = tree.select { |student| student.birthdate > "1997-12-31" }
filtr_students.each { |student| puts student }

# Тестирование стратегии JSON
puts "\nТестирование стратегии JSON:"
json_strategy = JSONStrategy.new
json_list = StudentsListBase.new('students.json', json_strategy)

# Добавляем студентов в список JSON
json_list.add_student(student1)
json_list.add_student(student2)
json_list.add_student(student3)
json_list.add_student(student4)

# Загружаем и выводим список из JSON
puts "Студенты из JSON:"
json_list.load_from_file
json_list.students.each { |student| puts student }

# Тестирование стратегии YAML
puts "\nТестирование стратегии YAML:"
yaml_strategy = YAMLStrategy.new
yaml_list = StudentsListBase.new('students.yaml', yaml_strategy)

# Добавляем студентов в список YAML
yaml_list.add_student(student1)
yaml_list.add_student(student2)
yaml_list.add_student(student3)
yaml_list.add_student(student4)

# Загружаем и выводим список из YAML
puts "Студенты из YAML:"
yaml_list.load_from_file
yaml_list.students.each { |student| puts student }

# Проверка сортировки в YAML
puts "\nСортировка студентов из YAML по фамилии:"
yaml_list.sort_by_initials!
yaml_list.students.each { |student| puts "#{student.surname} #{student.first_name} #{student.last_name}" }
