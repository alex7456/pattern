
require_relative 'Student'


student1 = Student.new(id: '1',surname: 'Иванов', name: 'Иван', patronymic: 'Иванович', phone: '111-222-333',telegram: 'ivan123', email:'ivan@mail.ru',git:'ivan123')
student2 = Student.new(id: '2',surname: 'Петров', name: 'Петр', patronymic: 'Петрович', phone: '123-456-789',telegram: 'petr123', email:'petr@mail.ru',git:'petr123')


def print_student_info(student)
  puts "ID: #{student.id}"
  puts "ФИО: #{student.surname} #{student.name} #{student.patronymic}"
  puts "Телефон: #{student.phone}" if student.phone
  puts "Телеграм: #{student.telegram}" if student.telegram
  puts "Почта: #{student.email}" if student.email
  puts "Гит: #{student.git}" if student.git
end


print_student_info(student1)
print_student_info(student2)
