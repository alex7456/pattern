require_relative './FilterDecorator'

class SortByFullnameFilter < FilterDecorator
  def apply_filter(data)
    super(data).sort_by(&:fullname)
  end
end
