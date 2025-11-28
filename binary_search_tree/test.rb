require_relative 'main'

def orders(tree)
  puts 'PRE-order'
  tree.preorder do |node|
    print "#{node.data}-"
  end
  print "\n"

  puts 'POST-order'
  tree.postorder do |node|
    print "#{node.data}-"
  end
  print "\n"

  puts 'IN-order'
  tree.inorder do |node|
    print "#{node.data}-"
  end
  print "\n"
end

tree = Tree.new(Array.new(15) { rand(0..100) })
puts tree.balanced?
orders(tree)

# do some unbalancing of the tree
10.times do
  tree.insert(rand(100..200))
end
puts "now balanced: #{tree.balanced?}"
puts tree.pretty_print

puts 'Now rebalancing...'
tree.rebalance
puts "now balanced: #{tree.balanced?}"
puts tree.pretty_print
orders(tree)
