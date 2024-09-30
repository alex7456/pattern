class Student_short
  attr_reader :id, :surname_initials, :git, :contact

  def initialize(arg1, arg2 = nil)
    if arg2.nil? && arg1.is_a?(Student)
      
      student = arg1
      @id = student.id
      @surname_initials = "#{student.surname} #{student.name[0]}.#{student.patronymic[0]}."
      @git = student.git
      @contact = extract_contact(student) 
    elsif arg2.is_a?(String)
      @id = arg1
      parse_info_str(arg2)
    else
      raise ArgumentError, "Неверные аргументы для инициализации Student_short"
    end
  end

  private

  
  def extract_contact(student)
    contacts = []
    contacts << "Телефон: #{student.phone}" if student.phone
    contacts << "Email: #{student.email}" if student.email
    contacts << "Телеграм: #{student.telegram}" if student.telegram
    contacts.empty? ? "Нет контактов" : contacts.join(", ")  
  end

  def parse_info_str(info_str)
    info_parts = info_str.split(',').map(&:strip)

    if info_parts.size != 3
      raise ArgumentError, "Неправильный формат строки"
    end

    @surname_initials = info_parts[0] 
    @git = info_parts[1]              
    @contact = info_parts[2]          
  end
end
