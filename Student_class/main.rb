require_relative "Student"
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
  student3 = Student.new(id: '3', surname: 'Сидоров', name: 'Егор', patronymic: 'Егорович', git:'egor123')
  student3.set_contacts(email: 'egor@example.com')
  student3.validate
rescue ArgumentError => e
  puts e.message
  student3 = nil
end


def print_student_info(student)
  if student.nil?
    puts "Студент не создан из-за ошибки в данных."
    return
  end

  puts "ID: #{student.id}"
  puts "ФИО: #{student.surname} #{student.name} #{student.patronymic}"
  puts "Телефон: #{student.phone}" if student.phone
  puts "Телеграм: #{student.telegram}" if student.telegram
  puts "Почта: #{student.email}" if student.email
  puts "Гит: #{student.git}" if student.git
  puts "-" * 20
end

print_student_info(student1)
print_student_info(student2)
print_student_info(student3)
