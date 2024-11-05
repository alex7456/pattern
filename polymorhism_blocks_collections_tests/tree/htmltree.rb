
require_relative 'HtmlTag'

class HtmlTree
  include Enumerable

  attr_reader :root

  def initialize(html_structure)
    @root = parse_html(html_structure)
  end

  def each(&block)
    depth_first(@root, &block)
  end

  def each_breadth_first(&block)
    breadth_first(@root, &block)
  end

  private

  # Простой парсер HTML для создания структуры дерева
  def parse_html(html)
    # Разбиваем строку на теги
    tokens = html.scan(/<\/?[^>]+>/)
    root = HtmlTag.new('html')
    current = root

    tokens.each do |token|
      if token.start_with?('</')
        # Закрывающий тег, возвращаемся к родительскому элементу
        current = current.parent if current.parent
      else
        # Открывающий тег, создаем новый узел и добавляем его как дочерний
        tag_name = token.match(/<(\w+)/)[1]
        new_tag = HtmlTag.new(tag_name)
        current.add_child(new_tag)
        current = new_tag unless token.end_with?('/>')
      end
    end
    root
  end

  # Обход в глубину (рекурсивный)
  def depth_first(tag, &block)
    block.call(tag)
    tag.children.each { |child| depth_first(child, &block) }
  end

  # Обход в ширину (с использованием очереди)
  def breadth_first(tag, &block)
    queue = [tag]
    until queue.empty?
      current = queue.shift
      block.call(current)
      queue.concat(current.children)
    end
  end
end
