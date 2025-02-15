class DataList
  def initialize(elements)
    self.data = elements
    @extract_names = extract_names
    @selected=[]
  end
  def select(number)
    raise IndexError, "Invalid number" unless self.class.valid_index?(number,data)

    @selected << data[number]
    @selected.uniq

  end
  def get_selected
    @selected.dup
  end


  def get_data
    rows = data.map.with_index(1) { |element, index| extract_data(element, index) }
    Data_table.new(rows)
  end
  def get_names
    @extract_names
  end
  def to_s
    @data.inspect
  end
  attr_reader :data

  def data=(data)
    @data = data.map { |element| deep_dup(element) }
  end

  attr_accessor :selected

  protected


  def self.valid_index?(number,data)
    number.between?(0, data.size - 1)
  end


  def deep_dup(element)
    if element.is_a?(Array)
      element.map { |sub_element| deep_dup(sub_element) }
    else
      begin
        element.dup
      rescue
        element
      end
    end
  end
  def extract_names
    raise NotImplementedError, "Must implement extract_names in subclass"
  end

  def extract_data(element, index)
    raise NotImplementedError, "Must implement extract_data in subclass"
  end

end
