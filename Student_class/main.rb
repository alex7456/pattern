require_relative 'Student'
require_relative 'Student_short'

begin
  student1 = Student.new(id: '1', surname: 'Иванов', name: 'Иван', patronymic: 'Иванович', git: 'ivan123')
  student1.set_contacts(phone: '111-222-333', telegram: 'ivan123', email: 'ivan@mail.ru')
  student1.validate
rescue ArgumentError => e
  puts e.message
  student1 = nil
end

begin
  student2 = Student.new(id: '2', surname: 'Петров', name: 'Петр', patronymic: 'Петрович', git: 'petr123')
  student2.set_contacts(phone: '222-333-444')
  student2.validate
rescue ArgumentError => e
  puts e.message
  student2 = nil
end

begin
  student3 = Student.new(id: '3', surname: 'Сидоров', name: 'Егор', patronymic: 'Егорович', git: 'egor123')
  student3.set_contacts(email: 'egor@example.com')
  student3.validate
rescue ArgumentError => e
  puts e.message
  student3 = nil
end

student4 = Student.new(id: '4', surname: 'Селезнев', name: 'Александр', patronymic: 'Александрович', git: 'as123')
student4.set_contacts(phone: '123-456-789')

student_short1 = Student_short.new(student4)

student_short2 = Student_short.new('5', 'Александров А.А., petrGit, Телефон: 987-654-321')

def print_student_info(student)
  if student.nil?
    puts "Студент не создан из-за ошибки в данных."
    return
  end

  puts student.getInfo
  puts "-" * 20
end

print_student_info(student1)
print_student_info(student2)
print_student_info(student3)

puts "Student_short1: ID=#{student_short1.id}, Surname Initials=#{student_short1.surname_initials}, Git=#{student_short1.git}, Contact=#{student_short1.get_contact}"
puts "Student_short2: ID=#{student_short2.id}, Surname Initials=#{student_short2.surname_initials}, Git=#{student_short2.git}, Contact=#{student_short2.get_contact}"
