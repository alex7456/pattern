require_relative 'PersonBase'
class Student < PersonBase
  attr_reader :email, :phone, :telegram, :first_name, :surname, :last_name

  def initialize(first_name:, surname:, last_name:, phone: nil, telegram: nil, git:, email: nil, id: nil)
    super(id: id, git: git)
    raise "FIO required" if first_name.nil? || surname.nil? || last_name.nil?

    set_attribute(:first_name, first_name) 
    set_attribute(:surname, surname)
    set_attribute(:last_name, last_name)
    set_contacts(phone: phone, telegram: telegram, email: email)   
  end

  def set_contacts(phone: nil, telegram: nil, email: nil)
    set_attribute(:phone, phone) if phone
    set_attribute(:telegram, telegram) if telegram
    set_attribute(:email, email) if email
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
