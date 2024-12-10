 require_relative 'data_list'
require_relative 'data_table'
class Data_list_student_short < DataList

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
