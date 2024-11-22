class Student < Human
  attr_reader :first_name, :surname, :last_name

  NAME_REGEX = /^[А-Яа-яЁёA-Za-z]+$/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PHONE_REGEX = /^\d{1,3}-\d{3}-\d{3}$/
  TELEGRAM_REGEX = /^@[a-zA-Z0-9_]{5,}$/

  def initialize(first_name:, surname:, last_name:, email: nil, phone: nil, telegram: nil, id: nil, github: nil)
    super(id: id, github: github)
    self.first_name = first_name
    self.surname = surname
    self.last_name = last_name
    set_contact(phone: phone, telegram: telegram, email: email)
  end

  def self.valid_name?(name)
    name =~ NAME_REGEX
  end

  def self.valid_email?(email)
    email =~ EMAIL_REGEX
  end

  def self.valid_phone?(phone)
    phone =~ PHONE_REGEX
  end

  def self.valid_telegram?(telegram)
    telegram =~ TELEGRAM_REGEX
  end

  def first_name=(value)
    raise ArgumentError, "Invalid first name" unless self.class.valid_name?(value)
    @first_name = value
  end

  def surname=(value)
    raise ArgumentError, "Invalid surname" unless self.class.valid_name?(value)
    @surname = value
  end

  def last_name=(value)
    raise ArgumentError, "Invalid last name" unless self.class.valid_name?(value)
    @last_name = value
  end

  def set_contact(phone: nil, telegram: nil, email: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
  end

  def contact
    contacts = []
    contacts << "Почта: #{@email}" if @email
    contacts << "Телефон: #{@phone}" if @phone
    contacts << "Телеграмм: #{@telegram}" if @telegram
    contacts.join(", ")
  end

  def initials
    "#{surname}#{first_name[0]}.#{last_name[0]}."
  end
  def get_info
    info = []
    info << "Инициалы:#{initials}"
    info << "#{contact}" if contact
    info << "Git:#{@github}" if @github
    info.join(", ")
  end
  private def email=(value)
    raise ArgumentError, "Invalid email" unless self.class.valid_email?(value)
    @email = value
  end

  private def phone=(value)
    raise ArgumentError, "Invalid phone" unless self.class.valid_phone?(value)
    @phone = value
  end

  private def telegram=(value)
    raise ArgumentError, "Invalid telegram" unless self.class.valid_telegram?(value)
    @telegram = value
  end

  def contact_present?(contact)
    !contact.nil? && !contact.empty?
  end

  def validate?
    github_present?(@github) || contact_present?(contact)
  end

  def to_s
    data = []
    data << "id : #{@id}" if @id
    data << "Фамилия: #{@surname}" if @surname
    data << "Имя: #{@first_name}" if @first_name
    data << "Отчество: #{@last_name}" if @last_name
    data << "github: #{@github}" if @github
    data << "telegram: #{@telegram}" if @telegram
    data << "email: #{@email}" if @email
    data << "Телефон: #{@phone}" if @phone
    data.join("\n")
  end
end
