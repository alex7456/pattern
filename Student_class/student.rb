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
  def initialize(first_name: , surname: , last_name: ,email:nil,phone:nil,telegram:nil,id:nil,git:nil,birthdate:nil)
    super(id: id, git:git)
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
    birthdate =~ DATE_REGEX
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
    if self.class.valid_birthdate?(value)
      @birthdate = value
    else
      raise ArgumentError, "Invalid birthdate"
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
    "#{surname}#{first_name.is_a?(String) ? first_name[0]&.upcase : ''}. #{last_name.is_a?(String) ? last_name[0]&.upcase : ''}."
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
    git_present?(@git) || contact_present?(contact)
  end

  def self.from_hash(hash)
    id = hash[:id]&.to_i
    last_name = hash[:last_name]&.strip
    first_name = hash[:first_name]&.strip
    surname = hash[:surname]&.strip
    phone = normalize_contact(hash[:phone])
    telegram = normalize_contact(hash[:telegram])
    email = normalize_contact(hash[:email])
    git = normalize_contact(hash[:git])
    birthdate = parse_birthdate(hash[:birthdate])

    new(
      id: id,
      last_name: last_name,
      first_name: first_name,
      surname: surname,
      phone: phone,
      telegram: telegram,
      email: email,
      git: git,
      birthdate: birthdate
    )
  end



  # Метод для нормализации контактов
  private def self.normalize_contact(value)
    return nil if value.nil? || value.strip.empty?
    value.strip
  end

  # Метод для обработки даты рождения
  private def self.parse_birthdate(value)
    return nil if value.nil? || value.strip.empty? # Проверка на nil и пустую строку

    begin
      Date.parse(value.strip)
    rescue ArgumentError => e
      raise "Ошибка в формате даты: #{e.message}"
    end
  end


  def to_s
    data = []
    data << "ID: #{@id}" if id
    data << "firstName: #{@first_name}" if first_name
    data << "surname: #{@surname}" if surname
    data << "lastName: #{@last_name}" if last_name
    data << "email: #{@email}" if @email
    data << "phone: #{@phone}" if @phone
    data << "telegram: #{@telegram}" if @telegram
    data << "Git: #{@git}" if git
    data << "Birthdate: #{@birthdate}" if birthdate
    data.join("\n")

  end
  def <=>(other)
    other.birthdate <=> self.birthdate
  end

  def ==(other)
    if @phone && other.phone && @phone == other.phone || @git && other.git && @git == other.git || @email && other.email && @email == other.email || @telegram && other.telegram && @telegram == other.telegram
      return true
    end
    return false
  end
  end
