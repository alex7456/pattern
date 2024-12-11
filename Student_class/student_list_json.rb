require 'json'
require_relative 'Student'
require_relative 'Student_short'
require_relative 'DataList/Data_list_student_short'

class StudentsListJSON
  def initialize(file_path)
    @file_path = file_path
    @students = []
    load_from_file
  end

  # Загрузка данных из файла
  def load_from_file
    if File.exist?(@file_path)
      file_content = File.read(@file_path)
      @students = JSON.parse(file_content, symbolize_names: true).map do |data|
        Student.new(
          first_name: data[:first_name],
          last_name: data[:last_name],
          surname: data[:surname],
          phone: data[:phone],
          telegram: data[:telegram],
          email: data[:email],
          git: data[:git],
          birthdate: data[:birthdate],
          id: data[:id]
        )
      end
    else
      @students = []
    end
  end


  # Сохранение данных в файл
  def save_to_file
    serialized_data = @students.map do |student|
      {
        id: student.id,
        lastname: student.last_name,
        firstname: student.first_name,
        surname: student.surname,
        contact: student.contact,
        github: student.git,
        birth_date: student.birthdate
      }
    end
    File.open(@file_path, 'w') do |file|
      file.write(JSON.pretty_generate(serialized_data))
    end
  end

  # Найти студента по ID
  def find_by_id(id)
    @students.find { |student| student.id == id }
  end

  # Получить список k по счету n объектов StudentShort
  def get_k_n_student_short_list(k, n, existing_data_list = nil)
    start_index = (k - 1) * n
    selected_students = @students[start_index, n] || []
    short_list = selected_students.map { |student| Student_short.from_student(student) }

    if existing_data_list
      existing_data_list.data = short_list
      short_list.each_with_index { |_, i| existing_data_list.select(i) }
      existing_data_list
    else
      data_list = Data_list_student_short.new(short_list)
      short_list.each_with_index { |_, i| data_list.select(i) }
      data_list
    end
  end

  # Сортировка студентов по ФамилияИнициалы
  def sort_by_initials!
    @students.sort_by! do |student|
      "#{student.last_name}#{student.surname[0]}#{student.first_name[0]}"
    end
  end


  # Добавить нового студента
  def add_student(student)
    new_id = (@students.map(&:id).max || 0) + 1
    student.id = new_id
    @students << student
    save_to_file
  end

  # Обновить студента по ID
  def update_by_id(id, updated_student)
    index = @students.find_index { |student| student.id == id }
    return false unless index

    updated_student.id = id
    @students[index] = updated_student
    save_to_file
    true
  end

  # Удалить студента по ID

  def delete_by_id(id)
    @students.reject! { |student| student.id == id }
    reassign_ids # Обновляем индексы после удаления
    save_to_file
  end

  # Перенумерация ID после удаления
  def reassign_ids
    @students.each_with_index { |student, index| student.id = index + 1 }
  end

  # Получить количество студентов
  def count
    @students.size
  end
end
