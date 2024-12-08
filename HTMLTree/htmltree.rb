require_relative 'HtmlTag'

class HtmlTree
  include Enumerable

  ALLOWED_TAGS = %w[html head body div p h1 h2 ul li a span].freeze
  ALLOWED_ATTRIBUTES = %w[class id href src].freeze

  attr_accessor :root

  def initialize(html_string)
    @root = parse_html(html_string)
  end

  # Парсинг строки HTML
  def parse_html(html_string)
    tokens = html_string.gsub(/\s+/, ' ').scan(/<\/?[^>]+>/)
    current_node = nil
    stack = []

    tokens.each do |token|
      if token =~ /<\/(\w+)>/
        stack.pop
        current_node = stack.last
      elsif token =~ /<(\w+)([^>]*)>/
        tag_name, attributes_string = $1, $2
        next unless ALLOWED_TAGS.include?(tag_name)

        attributes = parse_attributes(attributes_string)
        tag = HtmlTag.new(tag_name, attributes)

        if current_node
          current_node.add_child(tag)
        else
          @root = tag
        end

        stack.push(tag)
        current_node = tag
      end
    end
    @root
  end

  # Парсинг атрибутов тега
  def parse_attributes(attributes_string)
    attributes = {}
    attributes_string.scan(/(\w+)="([^"]+)"/).each do |key, value|
      attributes[key] = value if ALLOWED_ATTRIBUTES.include?(key)
    end
    attributes
  end

  # each с обходом в глубину (DFS)
  def each_depth_first(&block)
    traverse_depth_first(@root, &block)
  end

  def traverse_depth_first(tag, &block)
    yield tag
    tag.children.each { |child| traverse_depth_first(child, &block) }
  end

  # each с обходом в ширину (BFS)
  def each_breadth_first(&block)
    queue = [@root]
    until queue.empty?
      tag = queue.shift
      yield tag
      queue.concat(tag.children)
    end
  end

  # Основной each с обходом в глубину по умолчанию
  def each(&block)
    each_depth_first(&block)
  end
end
