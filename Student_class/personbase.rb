class PersonBase
  attr_reader :phone, :email, :telegram

 def set_contact(phone: nil, email: nil, telegram: nil)
  { phone: phone, email: email, telegram: telegram }.each do |field, value|
    next if value.nil?  # Пропустить, если значение не указано

    case field
    when :phone
      validate(value, :phone)
    when :email
      validate(value, :email)
    when :telegram
      validate(value, :telegram)
    else
      raise ArgumentError, "Неизвестное поле: #{field}"
    end

    instance_variable_set("@#{field}", value)
  end
  validate_contact
end

  def get_contact
    contacts = {
      "Телефон" => phone,
      "Email" => email,
      "Телеграм" => telegram
    }.compact.map { |key, value| "#{key}: #{value}" }

    contacts.empty? ? "Нет контактов" : contacts.join(", ")
  end

  # Упрощенный метод валидации с единой логикой для всех типов контактов
  def validate(value, field)
    case field
    when :phone
      raise ArgumentError, "Недопустимый телефон: #{value}" unless self.class.valid_phone_number?(value)
    when :email
      raise ArgumentError, "Недопустимый email: #{value}" unless self.class.valid_email?(value)
    when :telegram
      raise ArgumentError, "Недопустимый Telegram: #{value}" unless self.class.valid_telegram?(value)
    end
  end

  # Валидационные методы
  def self.valid_phone_number?(phone)
    phone.match?(/\A(\+?\d{1,3})?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{3,4}\z/)
  end

  def self.valid_email?(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def self.valid_telegram?(telegram)
    telegram.match?(/\A\w+\z/)
  end

  private

  def validate_contact
    raise ArgumentError, "Необходимо указать хотя бы один контакт: телефон, email или Телеграм" if [phone, email, telegram].all?(&:nil?)
  end
end
