require_relative 'data_list'
require_relative 'data_table'

class Data_list_student_short < DataList
  attr_accessor :count
  def initialize(elements)
    super(elements)
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify
    @observers.each do |observer|
      observer.set_table_params(self.column_names, @count)  # Используем self.column_names
      observer.set_table_data(get_data)
    end
  end

  def column_names
    ["ID", "ФИО", "Контакт", "Git"]  # Заголовки колонок
  end

  private

  def extract_names
    %w[initials contact git]
  end

  def extract_data(student, index)
    [
      index,
      student.initials,
      student.contact,
      student.git
    ]
  end
end
