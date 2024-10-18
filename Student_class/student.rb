require_relative 'PersonBase'
class Student < PersonBase
  
  attr_reader :id, :surname_initials, :git

  def initialize(id:, surname:, name:, patronymic:, git:)
    @id = id
    @git = git

    validate_git(git)
    validate_fio(surname, name, patronymic)

    # Сохраняем только необходимые данные
    @surname_initials = generate_initials(surname, name, patronymic)
  end

  def get_full_info
    "#{surname_initials}; Git: #{git}; Связь: #{get_contact}"
  end

  private

  def generate_initials(surname, name, patronymic)
    "#{surname} #{name[0]}.#{patronymic[0]}."
  end

  def validate_git(git)
    raise ArgumentError, "Необходимо указать Git" if git.nil? || git.empty?
  end

  def validate_fio(surname, name, patronymic)
    { 'Фамилия' => surname, 'Имя' => name, 'Отчество' => patronymic }.each do |field_name, field_value|
      validate_name_part(field_value, field_name)
    end
  end

  def validate_name_part(name_part, field_name)
    if name_part.nil? || name_part.strip.empty?
      raise ArgumentError, "#{field_name} не может быть пустым"
    end

    unless name_part =~ /\A[А-Яа-яЁёA-Za-z]+\z/
      raise ArgumentError, "#{field_name} должно содержать только буквы"
    end
  end
end
