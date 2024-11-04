class HtmlTag
  attr_reader :name, :children, :parent

  def initialize(name)
    @name = name
    @children = []
    @parent = nil
  end

  # Метод для добавления дочернего элемента
  def add_child(child)
    child.set_parent(self) # Устанавливаем родителя
    @children << child
  end

  # Метод для установки родителя (приватный)
  def set_parent(parent)
    @parent = parent
  end
end
