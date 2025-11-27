require_relative 'hash_map'
require_relative 'hash_set'

# Test HashMap
map = HashMap.new
map.set('apple', 'red')
map.set('banana', 'yellow')
map.set('carrot', 'orange')
map.set('dog', 'brown')
map.set('elephant', 'gray')
map.set('frog', 'green')
map.set('grape', 'purple')
map.set('hat', 'black')
map.set('ice cream', 'white')
map.set('jacket', 'blue')
map.set('kite', 'pink')
map.set('lion', 'golden')
map.set('asd', 'golden')
map.set('b', 123)

puts 'okay'
map.set('THIS WILL GROW', 'golden')

map.set('zvvvv MAP', 'golden')
p map.get('b')

map.set('a', 'golden')
map.set('e', 'golden')
map.set('g', 'golden')
puts map.length

map.remove('ice cream')
map.remove('jacket')
map.remove('kite')
map.remove('lion')
map.set('frog', 'BLUE')
puts map

# Test HashSet
map = HashSet.new
map.set('apple')
map.set('banana')
map.set('carrot')
map.set('dog')
map.set('elephant')
map.set('frog')
map.set('grape')
map.set('hat')
map.set('ice cream')
puts map.entries

map.remove('ice cream')
map.remove('jacket')
map.remove('kite')
map.remove('lion')
puts map.entries
puts map
map.set('frog')
p map.keys
puts map
map.clear
puts map
map.set('ice cream')
puts map
puts map.entries
