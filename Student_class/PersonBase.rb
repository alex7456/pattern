class PersonBase
  attr_accessor :id, :surname_initials, :git
  attr_reader :phone, :email, :telegram

  def initialize(id:, surname_initials:, git:)
    @id = id
    @surname_initials = surname_initials
    @git = git
  end

  def set_contact(value, field)
  # Хеш, связывающий поля с методами валидации
  validators = {
    phone: :valid_phone_number?,
    email: :valid_email?,
    telegram: :valid_telegram?
  }

  unless validators.keys.include?(field)
    raise ArgumentError, "Неизвестное поле: #{field}"
  end

  validator = self.class.method(validators[field])
  
  if value.nil? || validator.call(value)
    instance_variable_set("@#{field}", value)
  else
    raise ArgumentError, "Недопустимый #{field}: #{value}"
  end
end



def set_contacts(phone: nil, email: nil, telegram: nil)
  set_contact(phone, :phone) unless phone.nil?
  set_contact(email, :email) unless email.nil?
  set_contact(telegram, :telegram) unless telegram.nil?
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

  

  def validate_contact
    raise ArgumentError, "Необходимо указать хотя бы один контакт: телефон, email или Телеграм" if [phone, email, telegram].all?(&:nil?)
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
