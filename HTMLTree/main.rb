require_relative 'HtmlTree'

html_content = "<div><p>Text</p><span>Other</span></div>"
tree = HtmlTree.new(html_content)

puts "Обход в глубину:"
tree.each { |tag| puts tag.name }

puts "Обход в ширину:"
tree.each_breadth_first { |tag| puts tag.name }
