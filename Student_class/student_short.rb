require_relative 'Student'

class Student_short < PersonBase
  attr_reader :fio, :contact

  def initialize(student: nil, id: nil, student_str: nil)
    if student
      super(id: student.id, git: student.git)
      short_setter(student.get_info)
    elsif id && student_str
      super(id: id)
      short_setter(student_str)
    else
      raise ArgumentError, "Invalid arguments for StudentShort"
    end
  end

  private

  def short_setter(info)
    info_arr = info.split("\t")
    set_attribute(:fio, info_arr[0])
    set_attribute(:git, info_arr[1])
    set_attribute(:contact, info_arr[2])
  end
end
