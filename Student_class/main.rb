require_relative 'Human'
require_relative 'Student'
require_relative 'Student_short'
require_relative 'student_tree'
student_info = {
  id: 1,
  first_name: "Иван",
  surname: "Иванов",
  last_name: "Иванович",
  phone: "111-222-333",
  telegram: "@ivanov",
  email: "ivanov@ya.ru",
  git: "https://github.com/ivanov",
  birthdate:"2000-05-15"
}
student = Student.new(**student_info)
puts "#{student}#{student.validate?}"

string = "ID: 2; Инициалы: ТестовТ.Т.; GitHub: https://github.com/test; Контакт: 111-222-333"
short_student = Student_short.from_string(string)
puts "#{short_student}#{short_student.validate?}"

sheet_student=Student_short.from_student(student)
puts "#{sheet_student}#{sheet_student.validate?}"

student1 = Student.new(first_name: "Иван", surname: "Иванов", last_name: "Иванович", birthdate: "2000-05-15")
student2 = Student.new(first_name: "Петр", surname: "Петров", last_name: "Петрович", birthdate: "1998-08-20")
student3 = Student.new(first_name: "Алексей", surname: "Алексеев", last_name: "Алексеевич", birthdate: "2002-03-10")
student4 = Student.new(first_name: "Мария", surname: "Сидорова", last_name: "Александровна", birthdate: "1997-12-31")
tree = StudentTree.new
tree.add(student1)
tree.add(student2)
tree.add(student3)
tree.add(student4)
puts "Все студенты в порядке даты рождения:"
tree.each { |student| puts "#{student.surname} #{student.birthdate}" }
