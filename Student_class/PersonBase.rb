class PersonBase
  attr_accessor :id, :surname_initials, :git
  attr_reader :phone, :email, :telegram

  def initialize(id:, surname_initials:, git:)
    @id = id
    @surname_initials = surname_initials
    @git = git
  end

  def set_contacts(phone: nil, email: nil, telegram: nil)
    set_phone(phone) unless phone.nil?
    set_email(email) unless email.nil?
    set_telegram(telegram) unless telegram.nil?
    validate_contact
  end

  def get_contact
    contacts = []
    contacts << "Телефон: #{phone}" if phone
    contacts << "Email: #{email}" if email
    contacts << "Телеграм: #{telegram}" if telegram
    contacts.empty? ? "Нет контактов" : contacts.join(", ")
  end

  private

  def set_phone(value)
    if value.nil? || self.class.valid_phone_number?(value)
      @phone = value
    else
      raise ArgumentError, "Недопустимый номер телефона: #{value}"
    end
  end

  def set_email(value)
    if value.nil? || self.class.valid_email?(value)
      @email = value
    else
      raise ArgumentError, "Недопустимый email: #{value}"
    end
  end

  def set_telegram(value)
    if value.nil? || self.class.valid_telegram?(value)
      @telegram = value
    else
      raise ArgumentError, "Недопустимый Telegram: #{value}"
    end
  end

  def validate_contact
    if phone.nil? && email.nil? && telegram.nil?
      raise ArgumentError, "Необходимо указать хотя бы один контакт: телефон, email или Телеграм"
    end
  end

  # Статические методы для валидации
  def self.valid_phone_number?(phone)
    !!(phone =~ /\A(\+?\d{1,3})?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{3,4}\z/)
  end

  def self.valid_email?(email)
    !!(email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def self.valid_telegram?(telegram)
    !!(telegram =~ /\A\w+\z/)
  end
end
