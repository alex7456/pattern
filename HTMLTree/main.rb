require_relative 'HtmlTree'

html = "
<html>
	<body>
		<div class=\"container\">
			<p>Hello, world!</p>
		</div>
		<div>
		</div>
	</body>
</html>"

tree = HtmlTree.new(html)
puts "\nМетод count для дерева: #{tree.count}"
puts "\nМетод find для дерева (условие - имя 'body'): #{tree.find{|x| x.name = "body"}.to_s}"
puts "\nМетод count с условием (имя div): #{tree.count{|x| x.name == "div"}}"
puts "\nКоличество детей у первого наследника корня: #{tree.root.children[0].count_children}"
puts "\nВывод экземпляра дерева в формате строки: #{tree.root}"
puts "\nВывод всех элементов дерева с помощью обхода в глубину: "
tree.each{|node| puts node}
puts "\nМетод has_children для всех элементов дерева: "
tree.each{|node| puts "#{node.name}: #{node.has_children?}"}
