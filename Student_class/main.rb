require 'json'
require 'yaml'
require_relative 'Entities/Student'
require_relative 'Entities/Student_short'
require_relative 'student_tree'
require_relative 'DataList/data_table'
require_relative 'DataList/data_list'
require_relative 'DataList/data_list_student_short'
require_relative 'Entities/Human'
require_relative 'student_list_json'
require_relative 'student_list_yaml'
require_relative 'StudentsListBase'
require_relative 'JSONStrategy'
require_relative 'YAMLStrategy'
require_relative 'file_strategy'
require_relative './Database/Connection'
require_relative './Database/StudentListDB'
require 'pg'

# Создаем тестовые данные студентов
student1 = Student.new(first_name: "Иван", surname: "Иванов", last_name: "Иванович", birthdate: "2000-05-15")
student2 = Student.new(first_name: "Петр", surname: "Петров", last_name: "Петрович", birthdate: "1998-08-20")
student3 = Student.new(first_name: "Алексей", surname: "Алексеев", last_name: "Алексеевич", birthdate: "2002-03-10")
student4 = Student.new(first_name: "Мария", surname: "Сидорова", last_name: "Александровна", birthdate: "1997-12-31")

# Подключение к базе данных
begin
  db = Connection.new(host: 'localhost', username: 'postgres', password: '12345', database: 'postgres')
  student_db = Students_list_DB.instance(db)

  puts "\n=== Тестирование метода add_student ==="
  student_db.add_student(student1)
  student_db.add_student(student2)
  student_db.add_student(student3)
  student_db.add_student(student4)
  puts "Студенты успешно добавлены в базу данных."

  puts "\n=== Тестирование метода get_student_count ==="
  count = student_db.get_student_count
  puts "Количество студентов в базе данных: #{count}"

  puts "\n=== Тестирование метода find_student_by_id ==="
  student = student_db.find_student_by_id(1)
  if student
    puts "Студент с ID 1 найден:"
    puts student
  else
    puts "Студент с ID 1 не найден."
  end

  puts "\n=== Тестирование метода get_k_n_student_short_list ==="
  short_list = student_db.get_k_n_student_short_list(1, 2) # Получаем первых двух студентов
  puts "Краткий список студентов (2 студента):"
  short_list.data.each { |student_short| puts student_short }

  puts "\n=== Тестирование метода update_student_by_id ==="
  updated_student = Student.new(
    first_name: "Александр",
    surname: "Смирнов",
    last_name: "Александрович",
    birthdate: "1999-01-01",
    phone: "+79150482266",
    email: "alexandr@example.com"
  )
  student_db.update_student_by_id(1, updated_student)
  puts "Студент с ID 1 обновлен."

  puts "\n=== Проверка обновленного студента ==="
  updated = student_db.find_student_by_id(1)
  puts updated

  puts "\n=== Тестирование метода delete_student_by_id ==="
  student_db.delete_student_by_id(4) # Удаляем студента с ID 4
  puts "Студент с ID 4 удален."

  puts "\n=== Тестирование метода get_student_count после удаления ==="
  count_after_delete = student_db.get_student_count
  puts "Количество студентов после удаления: #{count_after_delete}"

  puts "\n=== Итоговый список всех студентов ==="
  result = db.execute_query("SELECT * FROM student")
  result.each { |row| puts row }

rescue PG::Error => e
  puts "Ошибка подключения или выполнения запроса: #{e.message}"
ensure
  db.close if db
end

# Тестирование других частей программы
puts "\n=== Тестирование работы со стратегиями JSON и YAML ==="

# Тестирование стратегии JSON
puts "\nТестирование стратегии JSON:"
json_strategy = JSONStrategy.new
json_list = StudentsListBase.new('students.json', json_strategy)

json_list.add_student(student1)
json_list.add_student(student2)
json_list.add_student(student3)
json_list.load_from_file
puts "Студенты из JSON-файла:"
json_list.students.each { |student| puts student }

# Тестирование стратегии YAML
puts "\nТестирование стратегии YAML:"
yaml_strategy = YAMLStrategy.new
yaml_list = StudentsListBase.new('students.yaml', yaml_strategy)

yaml_list.add_student(student1)
yaml_list.add_student(student2)
yaml_list.add_student(student3)
yaml_list.load_from_file
puts "Студенты из YAML-файла:"
yaml_list.students.each { |student| puts student }

# Тестирование сортировки в YAML
puts "\nСортировка студентов из YAML по фамилии:"
yaml_list.sort_by_initials!
yaml_list.students.each { |student| puts "#{student.surname} #{student.first_name} #{student.last_name}" }
