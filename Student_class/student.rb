require_relative 'Human'
require 'date'

class Student < Human
  include Comparable
  attr_reader :first_name, :surname, :last_name, :birthdate, :phone, :email,:telegram
  NAME_REGEX = /^[А-Яа-яЁёA-Za-z]+$/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PHONE_REGEX = /^\+?\d{11,15}$/
  TELEGRAM_REGEX = /^@[a-zA-Z0-9_]{5,}$/
  DATE_REGEX = /^\d{4}-\d{2}-\d{2}$/
  def initialize(first_name: , surname: , last_name: ,email:nil,phone:nil,telegram:nil,id:nil,github:nil,birthdate:nil)
    super(id: id, github:github)
    self.first_name = first_name if first_name
    self.surname = surname if surname
    self.last_name = last_name if last_name
    self.birthdate = birthdate if birthdate
    set_contact(email:email,phone: phone, telegram: telegram)


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
  def self.valid_birthdate?(birthdate)
    birthdate.is_a?(Date) || (birthdate.is_a?(String) && birthdate =~ DATE_REGEX)
  end

  def first_name=(value)
    if self.class.valid_name?(value)
      @first_name = value
    else
      raise ArgumentError, "Invalid first name"
    end
  end
  def last_name=(value)
    if self.class.valid_name?(value)
      @last_name = value

   else
    raise ArgumentError, "Invalid last name"
   end


end
  def birthdate=(value)
    if value.is_a?(Date)
      @birthdate = value
    elsif value.is_a?(String) && self.class.valid_birthdate?(value)
      @birthdate = Date.parse(value)
    else
      raise ArgumentError, "Invalid birthdate format: #{value.inspect}"
    end
  end

  def surname=(value)
    if self.class.valid_name?(value)
      @surname = value
    else
      raise ArgumentError, "Invalid surname"
      end
  end
  private def email=(value)
    if self.class.valid_email?(value)
      @email = value
    else
      raise ArgumentError, "Invalid email"
  end
  end
  private def phone=(value)
    if self.class.valid_phone?(value)
      @phone = value
    else
      raise ArgumentError, "Invalid phone"
    end
  end
  private def telegram=(value)
    if self.class.valid_telegram?(value)
      @telegram = value
    else
      raise ArgumentError, "Invalid telegram"
      end
  end
  def set_contact(email: nil, phone: nil, telegram: nil)
    self.email = email if email
    self.phone = phone if phone
    self.telegram = telegram if telegram
  end
  def initials
    "#{surname} #{first_name&.slice(0, 1)&.upcase || ''}. #{last_name&.slice(0, 1)&.upcase || ''}."
  end



  def contact
    contacts = []
    contacts << "Email: #{@email}" if @email
    contacts << "Phone: #{@phone}" if @phone
    contacts << "Telegram: #{@telegram}" if @telegram
    contacts.join(",")
  end
  def contact_present?(contact)
    !contact.nil? && !contact.empty?
  end
  def validate?
    git_present?(@github) || contact_present?(contact)
  end

  def self.from_hash(hash)
    id = hash[:id]&.to_i
    last_name = hash[:last_name]&.strip
    first_name = hash[:first_name]&.strip
    surname = hash[:surname]&.strip
    phone = normalize_contact(hash[:phone])
    telegram = normalize_contact(hash[:telegram])
    email = normalize_contact(hash[:email])
    github = normalize_contact(hash[:github])
    birthdate = parse_birthdate(hash[:birthdate])

    new(
      id: id,
      last_name: last_name,
      first_name: first_name,
      surname: surname,
      phone: phone,
      telegram: telegram,
      email: email,
      github: github,
      birthdate: birthdate
    )
  end



  # Метод для нормализации контактов
   def self.normalize_contact(value)
    return nil if value.nil? || value.strip.empty?
    value.strip
  end
  private_class_method :normalize_contact
  # Метод для обработки даты рождения
  def self.parse_birthdate(value)
    return nil if value.nil?

    return value if value.is_a?(Date)
    value = value.strip if value.is_a?(String)

    begin
      Date.parse(value)
    rescue ArgumentError => e
      raise "Ошибка в формате даты: #{e.message}"
    end
  end

  private_class_method :parse_birthdate


  def to_s
    data = []
    data << "ID: #{@id}" if id
    data << "firstName: #{@first_name}" if first_name
    data << "surname: #{@surname}" if surname
    data << "lastName: #{@last_name}" if last_name
    data << "email: #{@email}" if @email
    data << "phone: #{@phone}" if @phone
    data << "telegram: #{@telegram}" if @telegram
    data << "Git: #{@github}" if github
    data << "Birthdate: #{@birthdate}" if birthdate
    data.join("\n")

  end
  def <=>(other)
    other.birthdate <=> self.birthdate
  end

  def ==(other)
    if @phone && other.phone && @phone == other.phone || @github && other.github && @github == other.github || @email && other.email && @email == other.email || @telegram && other.telegram && @telegram == other.telegram
      return true
    end
    return false
  end
  end
