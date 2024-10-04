require_relative 'PersonBase'

class Student < PersonBase
  attr_accessor :name, :surname, :patronymic

  def initialize(id:, surname:, name:, patronymic:, git:)
    full_name = "#{surname} #{name[0]}.#{patronymic[0]}."
    super(id: id, surname_initials: full_name, git: git)
    @name = name
    @surname = surname
    @patronymic = patronymic
    validate_fio
  end

  def getInfo
    "#{surname_initials}; Git: #{git}; Связь: #{get_contact}"
  end

  def validate
    raise ArgumentError, "Необходимо указать Git" if git.nil? || git.empty?
    validate_fio
    validate_contact
  end

  private

  # Валидация ФИО (фамилия, имя, отчество)
  def validate_fio
    validate_name_part(@surname, 'Фамилия')
    validate_name_part(@name, 'Имя')
    validate_name_part(@patronymic, 'Отчество')
  end

  # Валидация отдельной части ФИО (Фамилия, Имя, Отчество)
  def validate_name_part(name_part, field_name)
    if name_part.nil? || name_part.strip.empty?
      raise ArgumentError, "#{field_name} не может быть пустым"
    end

    unless name_part =~ /\A[А-Яа-яЁёA-Za-z]+\z/
      raise ArgumentError, "#{field_name} должно содержать только буквы"
    end
  end
end
