class Student_short < PersonBase
  def initialize(arg1, arg2 = nil)
    if arg1.is_a?(Student)
      student = arg1
      @contact = student.get_contact  # Получаем контакт напрямую из объекта Student
      super(id: student.id, surname_initials: student.surname_initials, git: student.git)
      
    elsif arg1.is_a?(String) && arg2.is_a?(String)
      info = parse_info(arg2)
      super(id: arg1, surname_initials: info[:surname_initials], git: info[:git])
      @contact = info[:contact]
      
    else
      raise ArgumentError, "Неверные аргументы для создания Student_short"
    end
  end

  def get_contact
    @contact || "Нет контактов"
  end

  private
  
  def parse_info(info_str)
    raise ArgumentError, "info_str не может быть nil" if info_str.nil?  # Проверяем на nil

    parts = info_str.split(',').map(&:strip)
    {
      surname_initials: parts[0],
      git: parts[1],
      contact: parts[2]
    }
  end
end
