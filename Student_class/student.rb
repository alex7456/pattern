# student.rb
require_relative 'PersonBase'

class Student < PersonBase
  attr_reader :surname_initials

  def initialize(id:, git:, surname:, name:, patronymic:)
    self.id = id  # Используем сеттер с валидацией
    self.git = git  # Используем сеттер с валидацией

    # Валидация ФИО
    validate_fio(surname, name, patronymic)

    # Сохраняем фамилию с инициалами
    @surname_initials = generate_initials(surname, name, patronymic)

   
  
  end

  def get_full_info
    "#{surname_initials}; Git: #{git}; Связь: #{get_contact}"
  end

  def get_contact
    contact_info = []
    contact_info << "Телефон: #{phone}" if phone
    contact_info << "Email: #{email}" if email
    contact_info << "Телеграм: #{telegram}" if telegram
    contact_info.empty? ? "Нет контактов" : contact_info.join(", ")
  end

  private

  def generate_initials(surname, name, patronymic)
    "#{surname} #{name[0]}.#{patronymic[0]}."
  end

  # Валидация ФИО
  def validate_fio(surname, name, patronymic)
    { 'Фамилия' => surname, 'Имя' => name, 'Отчество' => patronymic }.each do |field_name, field_value|
      validate_name_part(field_value, field_name)
    end
  end

  # Валидация отдельных частей ФИО
  def validate_name_part(name_part, field_name)
    if name_part.nil? || name_part.strip.empty?
      raise ArgumentError, "#{field_name} не может быть пустым"
    end

    unless name_part =~ /\A[А-Яа-яЁёA-Za-z]+\z/
      raise ArgumentError, "#{field_name} должно содержать только буквы"
    end
  end
end
