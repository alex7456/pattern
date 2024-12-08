
class HtmlTag
  attr_accessor :name, :attributes, :children

  def initialize(name, attributes = {})
    @name = name
    @attributes = attributes
    @children = []
  end

  # Добавление вложенного узла
  def add_child(tag)
    @children << tag
  end

  # Количество всех наследников первого уровня вложенности
  def count_children
    @children.size
  end

  # Проверка на принадлежность элемента классу
  def has_class?(class_name)
    classes = @attributes['class']&.split(' ') || []
    classes.include?(class_name)
  end

  # Проверка на наличие вложенных элементов
  def has_children?
    !@children.empty?
  end

  # Переопределение to_s
  def to_s
    "<#{@name}#{attributes_string}>#{children_string}</#{@name}>"
  end

  private

  # Преобразование всех атрибутов в одну строку
  def attributes_string
    @attributes.map { |k, v| " #{k}=\"#{v}\"" }.join('')
  end

  # Преобразование всех вложенных элементов в одну строку
  def children_string
    @children.map(&:to_s).join
  end
end
