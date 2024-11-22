class StudentShort < Human
  attr_reader :fio, :contact

  def initialize(fio:, contact:, id: nil, github: nil)
    super(id: id, github: github)
    @fio = fio
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
        data[:fio] = value
      when "github"
        data[:github] = value
      when "контакт"
        data[:contact] = value
      end
    end


    raise ArgumentError, "Missing required data: :fio or :contact" unless data[:fio] && data[:contact]

    new(**data)
  end


  def self.from_student(student)
    new(
      fio: student.initials,
      contact: student.contact,
      id: student.id,
      github: student.github
    )
  end

  def to_s
    data = []
    data << "id: #{@id}" if id
    data << "Инициалы: #{@fio}" if fio
    data << @contact if contact
    data << "Git: #{@github}" if github
    data.join("; ")
  end

  def validate?
    !github.nil? && !github.empty? && !contact.nil? && !contact.empty?
  end

  private_class_method :new
end
