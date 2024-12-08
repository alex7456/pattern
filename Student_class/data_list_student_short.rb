require_relative 'data_list'
require_relative 'data_table'
class Data_list_student_short < DataList
  # Возвращает массив имён атрибутов объектов (кроме ID)
  def get_names
    %w[initials contact git]
  end

  def get_data
    rows = data.map.with_index(1) do |student, index|
      [
        index,
        student.initials,
        student.contact,
        student.git
      ]
    end
    Data_table.new(rows)
  end
end
