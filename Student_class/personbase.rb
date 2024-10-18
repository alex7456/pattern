# person_base.rb
class PersonBase
  attr_reader :id, :git, :phone, :email, :telegram

  # Установка id с валидацией
  def id=(id)
    validate_id(id)
    @id = id
  end

  # Установка git с валидацией
  def git=(git)
    validate_git(git)
    @git = git
  end

  # Метод для установки контактов с валидацией
  def set_contacts(phone: nil, email: nil, telegram: nil)
    validate_contact(phone, 'телефон')
    validate_contact(email, 'email')
    validate_contact(telegram, 'телеграм')

    @phone = phone
    @email = email
    @telegram = telegram

    validate_contacts
  end

  

  # Валидационные методы для Git и ID
  def self.valid_git?(git)
    git.match?(/\A[a-zA-Z0-9._-]+\z/)  # Пример валидации формата Git
  end

  def self.valid_id?(id)
    id.match?(/\A\d+\z/)  # Пример валидации, что ID состоит только из цифр
  end
private
  # Валидация наличия контактов
  def validate_contacts
    raise ArgumentError, "Необходимо указать хотя бы один контакт: телефон, email или Телеграм" if @phone.nil? && @email.nil? && @telegram.nil?
  end

  def validate_id(id)
    raise ArgumentError, "Необходимо указать ID" if id.nil? || id.empty?
  end

  def validate_git(git)
    raise ArgumentError, "Необходимо указать Git" if git.nil? || git.empty?
    raise ArgumentError, "Недопустимый формат Git" unless self.class.valid_git?(git)
  end

  # Валидация контактов
  def validate_contact(value, contact_type)
    return if value.nil? || value.empty? # Если контакт не указан, пропускаем валидацию

    case contact_type
    when 'телефон'
      raise ArgumentError, "Недопустимый формат телефона" unless value.match?(/\A\d{1,3}-\d{3}-\d{3}\z/)
    when 'email'
      raise ArgumentError, "Недопустимый формат email" unless value.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    when 'телеграм'
      raise ArgumentError, "Недопустимый формат Telegram" unless value.match?(/\A[a-zA-Z0-9_]{5,}\z/) 
    else
      raise ArgumentError, "Неизвестный тип контакта"
    end
  end
end
