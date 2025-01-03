class Data_table
  def initialize(data)
    self.data = data
    end
  

  def get_element(row, col)
    if row >= 0 && row < row_count && col >= 0 && col < column_count
      @data[row][col]
    else
      raise IndexError, "index out of bounds"
    end
  end
  def row_count
    @data.count
  end
  def column_count
    @data[0].count
  end
  def to_s
    @data.inspect
  end
  private

  attr_reader :data

  def data=(data)
    unless data.is_a?(Array) && data.all? {|row| row.is_a?(Array)}
      raise ArgumentError, "Input data must be an Array"
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

    @data = data.map{ |row| row.map { |element| deep_dup(element) }}
  end
end
