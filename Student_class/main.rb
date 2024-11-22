require_relative 'Human'
require_relative 'Student'
require_relative 'Student_short'

student_info = {
  id: 1,
  first_name: "Иван",
  surname: "Иванов",
  last_name: "Иванович",
  phone: "111-222-333",
  telegram: "@ivanov",
  email: "ivanov@ya.ru",
  github: "https://github.com/ivanov"
}

student = Student.new(**student_info)
puts "#{student}, #{student.validate?}"

# Данные из строки и проверка на валидацию
string = "ID: 2; Инициалы: ТестовТ.Т.; GitHub: https://github.com/test; Контакт: 111-222-333"
student_short = StudentShort.from_string(string)
puts "#{student_short}, #{student_short.validate?}"

# Данные из объекта Student и проверка на валидацию
student_short = StudentShort.from_student(student)
puts "#{student_short}, #{student_short.validate?}"
