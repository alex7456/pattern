class Student_short < PersonBase
  def initialize(arg1, arg2 = nil)
    if arg1.is_a?(Student)
      student = arg1
      super(id: student.id, surname_initials: student.surname_initials, git: student.git)
      @contact = student.get_contact
    elsif arg1.is_a?(String) && arg2.is_a?(String)
      super(id: arg1, surname_initials: parse_surname_initials(arg2), git: parse_git(arg2))
      @contact = parse_contact(arg2)
    else
      raise ArgumentError, "Неверные аргументы для создания Student_short"
    end
  end

  def get_contact
    @contact || "Нет контактов"
  end

  private

  def parse_surname_initials(info_str)
    info_str.split(',').map(&:strip)[0]
  end

  def parse_git(info_str)
    info_str.split(',').map(&:strip)[1]
  end

  def parse_contact(info_str)
    info_str.split(',').map(&:strip)[2]  
  end
end

