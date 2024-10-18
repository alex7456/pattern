require_relative 'PersonBase'
require_relative 'Student'
require_relative 'Student_short'

begin
  student1 = Student.new(id: '1', surname: 'Иванов', name: 'Иван', patronymic: 'Иванович', git: 'ivan123')
  student1.set_contact(phone: '111-222-333', telegram: 'ivan123', email: 'ivan@mail.ru')
rescue ArgumentError => e
  puts e.message
end

begin
  student2 = Student.new(id: '2', surname: 'Стройный', name: 'Александр', patronymic: 'Александрович', git: 'alex7456')
  student2.set_contact(telegram: 'alex')
rescue ArgumentError => e
  puts e.message
end

student_short1 = Student_short.new(student2)

def print_student_info(student)
  if student.nil?
    puts "Студент не создан из-за ошибки в данных."
    return
  end

  puts student.get_full_info
  puts "-" * 20
end

print_student_info(student1)

puts "Student_short1: ID=#{student_short1.id}, Surname Initials=#{student_short1.surname_initials}, Git=#{student_short1.git}, Contact=#{student_short1.get_contact}"
