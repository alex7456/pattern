class Student_short < Human
  attr_reader :initials, :contact
  def initialize(initials:, contact:, id:nil, git:nil)
    super(id:id,git:git)
    @initials= initials
    @contact = contact
  end
  def self.from_string(string)
    data = {}
    string.scan(/([^:;]+): ([^;]+)(?:;|$)/).each do |key, value|
      key = key.strip.downcase
      value = value.strip

      case key
      when "id"
        data[:id] = value.to_i
      when "инициалы"
        data[:initials] = value
      when "github"
        data[:git] = value
      when "контакт"
        data[:contact] = value
      end
    end


    raise ArgumentError, "Missing required data: :fio or :contact" unless data[:initials] && data[:contact]

    new(**data)
  end
  def self.from_student(student)
    new(
      initials: student.initials,
    contact: student.contact,
    id: student.id,
    git: student.git,

    )

  end
  def to_s
    data = []
    data << "ID: #{@id}" if id
    data << "FIO: #{@initials}" if initials
    data << "Contact: #{@contact}" if contact
    data << "Git: #{@git}" if git
    data.join("\n")
  end
  def validate?
    !git.nil? && !git.empty? && !contact.nil? && !contact.empty?
  end
  private_class_method :new
end
