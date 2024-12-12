class StudentsListBase
  attr_reader :students

  def initialize(file_path, strategy)
    @file_path = file_path
    @strategy = strategy
    @students = []
    load_from_file
  end

  # Загрузка данных
  def load_from_file
    @students = @strategy.load(@file_path)
  end

  # Сохранение данных
  def save_to_file
    @strategy.save(@file_path, @students)
  end

  # Найти студента по ID
  def find_by_id(id)
    @students.find { |student| student.id == id }
  end

  # Добавить нового студента
  def add_student(student)
    new_id = (@students.map(&:id).max || 0) + 1
    student.id = new_id
    @students << student
    save_to_file
  end

  # Удалить студента по ID
  def delete_by_id(id)
    @students.reject! { |student| student.id == id }
    reassign_ids
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

  # Сортировка студентов по ФамилияИнициалы
  def sort_by_initials!
    @students.sort_by! do |student|
      "#{student.last_name}#{student.surname[0]}#{student.first_name[0]}"
    end
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

  # Перенумерация ID после удаления
  def reassign_ids
    @students.each_with_index { |student, index| student.id = index + 1 }
  end

  # Получить количество студентов
  def count
    @students.size
  end
end
