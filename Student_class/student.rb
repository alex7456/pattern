require_relative 'PersonBase'
class Student < PersonBase
  attr_reader :email, :phone, :telegram, :first_name, :surname, :last_name

  def initialize(first_name:, surname:, last_name:, phone: nil, telegram: nil, git: nil, email: nil, id: nil)
    super(id: id, git: git)
    self.first_name = first_name
    self.surname = surname
    self.last_name = last_name
    set_contacts(phone: phone, telegram: telegram, email: email)
  end

  def first_name=(value)
    set_attribute(:first_name, value)
  end

  def surname=(value)
    set_attribute(:surname, value)
  end

  def last_name=(value)
    set_attribute(:last_name, value)
  end

  def email=(value)
    set_attribute(:email, value)
  end

  def phone=(value)
    set_attribute(:phone, value)
  end

  def telegram=(value)
    set_attribute(:telegram, value)
  end

  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
  end

  def get_info
    fio = "#{@surname} #{initials}"
    git_info = git.nil? ? "Git не задан" : git 
    contact_info = get_contact

    "#{fio}\t#{git_info}\t#{contact_info}"
  end

  def initials
    "#{@first_name[0]}.#{@last_name[0]}."
  end

  def get_contact
    contact_info = []
    contact_info << "Телефон: #{@phone}" if @phone
    contact_info << "Email: #{@email}" if @email
    contact_info << "Telegram: #{@telegram}" if @telegram
    contact_info.empty? ? "Нет контактов" : contact_info.join(", ")
  end
end
