class Student_short < PersonBase

  attr_reader :contact

  def initialize(student)
    unless student.is_a?(Student)
      raise ArgumentError, "Неверные аргументы для создания Student_short"
    end

    @student = student # Сохраняем ссылку на объект Student
    @contact = student.get_contact
  end

  # Метод для получения id напрямую из объекта Student
  def id
    @student.id
  end

  # Метод для получения фамилии и инициалов напрямую
  def surname_initials
    @student.surname_initials
  end

  # Метод для получения git напрямую
  def git
    @student.git
  end

  # Метод для получения контакта
  def get_contact
    @contact || "Нет контактов"
  end
  end
