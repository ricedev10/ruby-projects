require_relative 'linkedlist'

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')
puts list

# test cases
list = LinkedList.new
list.append('first')
list.append('second')
list.append('third')
list.append('fourth')
list.append('fifth')
p list.size
puts list.head
puts list.tail
list.pop

list.each do |value|
  puts "Okay #{value}"
end
puts list.contains('third')
puts list.contains('none')
puts list.find('fourth')
puts list
list.insert_at('INSERT', 3)
puts list
list.remove_at(1)
puts list
list.remove_at(0)
puts list
