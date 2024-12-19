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
require_relative './DataStructure/student_list_adapter'
require_relative './DataStructure/student_list_adapter_DB'
require_relative './DataStructure/listadapter'
require 'pg'

# Создаем тестовые данные студентов
student1 = Student.new(first_name: "Иван", surname: "Иванов", last_name: "Иванович", birthdate: "2000-05-15")
student2 = Student.new(first_name: "Петр", surname: "Петров", last_name: "Петрович", birthdate: "1998-08-20")
student3 = Student.new(first_name: "Алексей", surname: "Алексеев", last_name: "Алексеевич", birthdate: "2002-03-10")
student4 = Student.new(first_name: "Мария", surname: "Сидорова", last_name: "Александровна", birthdate: "1997-12-31")

# Работа с адаптером базы данных
puts "\n=== Тестирование адаптера базы данных ==="
begin
  db_config = { host: 'localhost', user: 'postgres', password: '12345', dbname: 'postgres' }
  db_adapter = Students_list_db_adapter.new(db_config)
  list_adapter = List_adapter.new(db_adapter)

  # Добавление студентов
  puts "\nДобавление студентов в базу данных через адаптер:"
  list_adapter.add_student(student1)
  list_adapter.add_student(student2)
  list_adapter.add_student(student3)
  puts "Студенты успешно добавлены."

  # Получение количества студентов
  puts "\nКоличество студентов в базе данных:"
  puts list_adapter.get_student_short_count

  # Получение краткого списка студентов
  puts "\nКраткий список студентов (2 студента):"
  short_list = list_adapter.get_k_n_student_short_list(1, 2)
  short_list.data.each { |student_short| puts student_short }

  # Обновление студента
  puts "\nОбновление студента с ID 1:"
  updated_student = Student.new(
    first_name: "Александр",
    surname: "Смирнов",
    last_name: "Александрович",
    birthdate: "1999-01-01",
    phone: "+79150482266",
    email: "alexandr@example.com"
  )
  list_adapter.update_student_by_id(1, updated_student)

  # Проверка обновленного студента
  puts "\nПроверка обновленного студента:"
  puts list_adapter.find_student_by_id(1)

  # Удаление студента
  puts "\nУдаление студента с ID 3:"
  list_adapter.delete_student_by_id(3)
  puts "Студент удален."

  # Итоговый список студентов
  puts "\nИтоговый список студентов в базе данных:"
  short_list = list_adapter.get_k_n_student_short_list(1, 10)
  short_list.data.each { |student_short| puts student_short }
rescue PG::Error => e
  puts "Ошибка подключения или выполнения запроса: #{e.message}"
end

# Тестирование адаптера JSON
puts "\nТестирование адаптера JSON:"
json_strategy = JSONStrategy.new
json_adapter = Students_list_adapter.new('students_test.json', json_strategy)

# Использование адаптера через общий интерфейс
list_adapter = List_adapter.new(json_adapter)

# Добавление студентов
puts "\nДобавление студентов в JSON через адаптер:"
list_adapter.add_student(student1)
list_adapter.add_student(student2)
list_adapter.add_student(student3)
puts "Студенты успешно добавлены."


# Получение количества студентов
puts "\nКоличество студентов в JSON:"
puts list_adapter.get_student_short_count

# Получение краткого списка студентов
puts "\nКраткий список студентов (2 студента):"
short_list = list_adapter.get_k_n_student_short_list(1, 2)
short_list.data.each { |student_short| puts student_short }

# Обновление студента
puts "\nОбновление студента с ID 1:"
updated_student = Student.new(
  first_name: "Мария",
  surname: "Кузнецова",
  last_name: "Андреевна",
  birthdate: "2001-07-07"
)
list_adapter.update_student_by_id(1, updated_student)

# Проверка обновленного студента
puts "\nПроверка обновленного студента:"
puts list_adapter.find_student_by_id(1)

# Удаление студента
puts "\nУдаление студента с ID 2:"
list_adapter.delete_student_by_id(2)
puts "Студент удален."

# Итоговый список студентов
puts "\nИтоговый список студентов в JSON:"
short_list = list_adapter.get_k_n_student_short_list(1, 10)
short_list.data.each { |student_short| puts student_short }

# Работа с адаптером для YAML
puts "\n=== Тестирование адаптера YAML ==="
yaml_strategy = YAMLStrategy.new
yaml_adapter = Students_list_adapter.new('students.yaml', yaml_strategy)
list_adapter = List_adapter.new(yaml_adapter)

# Добавление студентов
puts "\nДобавление студентов в YAML через адаптер:"
list_adapter.add_student(student1)
list_adapter.add_student(student2)
list_adapter.add_student(student3)
puts "Студенты успешно добавлены."

# Получение краткого списка студентов
puts "\nКраткий список студентов из YAML (2 студента):"
short_list = list_adapter.get_k_n_student_short_list(1, 2)
short_list.data.each { |student_short| puts student_short }
