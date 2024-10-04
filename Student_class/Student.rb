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

  def get_full_info
    "#{surname_initials}; Git: #{git}; Связь: #{get_contact}"
  end

  def validate
  validate_git
    validate_fio
    validate_contact
  end

  private
 def validate_git
    raise ArgumentError, "Необходимо указать Git" if git.nil? || git.empty?
  end
  # Валидация ФИО (фамилия, имя, отчество)
  def validate_fio
    [@surname, @name, @patronymic].each_with_index do |name_part, index|
      field_name = %w[Фамилия Имя Отчество][index]
      validate_name_part(name_part, field_name)
    end
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
