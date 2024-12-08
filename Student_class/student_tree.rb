require_relative 'Student'
class StudentTree
  include Enumerable

  # Класс для узла дерева
  class Node
    attr_accessor :student, :left, :right

    def initialize(student)
      @student = student
      @left = nil
      @right = nil
    end
  end

  attr_accessor :root

  def initialize
    @root = nil
  end

  # Метод для добавления студента в дерево
  def add(student)
    new_node = Node.new(student)
    if @root.nil?
      @root = new_node
    else
      add_node(@root, new_node)
    end
  end

  private def add_node(current, new_node)
    # Используем переопределенный оператор "<=>"
    if new_node.student < current.student
      if current.left.nil?
        current.left = new_node
      else
        add_node(current.left, new_node)
      end
    else
      if current.right.nil?
        current.right = new_node
      else
        add_node(current.right, new_node)
      end
    end
  end

  # Подмешивание Enumerable
  def each(&block)
    traverse(@root, &block)
  end

  private def traverse(node, &block)
    return if node.nil?
    traverse(node.left, &block)
    yield node.student
    traverse(node.right, &block)
  end
end
