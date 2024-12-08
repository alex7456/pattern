class Data_table
  def initialize(data)
    if data.kind_of?(Array) && data.all? {|e| e.is_a?(Array)}
      @data = data
    else
      raise ArgumentError, "data must be an Array"
    end
  end
end
