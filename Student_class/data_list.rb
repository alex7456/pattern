class DataList
  def initialize(elements)
    self.data = elements
    @selected=[]
  end
  def select(number)
    raise IndexError, "Invalid number" unless number.between?(0, data.size - 1)

    @selected << data[number]
    @selected.uniq

  end
  def get_selected
@selected.map(&:id)
  end
  def get_data
    raise NotImplementedError
  end
  def get_names
    raise NotImplementedError
  end
  private
  attr_reader :data

  def data=(data)
    @data = data.map { |element| deep_dup(element) }
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

end
