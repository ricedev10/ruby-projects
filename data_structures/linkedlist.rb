# imitation of linked lists
class LinkedList
  attr_accessor :head

  def initialize(first_value = nil)
    @head = first_value.nil? ? nil : Node.new(first_value)
  end

  def append(value)
    @head = Node.new(value) and return if @head.nil?

    tail.next_node = Node.new(value)
  end

  def prepend(value)
    new_head = Node.new(value)
    new_head.next_node = @head
    @head = new_head
  end

  def size
    size = 1
    last_node = @head

    size += 1 and last_node = last_node.next_node until last_node.next_node.nil?
    size
  end

  def tail
    tail = @head
    tail = tail.next_node until tail.next_node.nil?
    tail
  end

  def at_index(index)
    i = 0
    match = @head
    match = match.next_node and i += 1 until i == index || match.next_node.nil?

    return match if i == index

    raise Error
  end

  def pop
    second_to_last = @head
    return if @head.next_node.nil?

    second_to_last = second_to_last.next_node until second_to_last.next_node.next_node.nil?
    second_to_last.next_node = nil
  end

  def each
    return if @head.nil?

    node = @head
    yield(node.value)
    node = node.next_node and yield(node.value) until node.next_node.nil?
  end

  def contains(value)
    each do |e|
      return true if e == value
    end

    false
  end

  def find(value)
    i = 0
    each do |e|
      return i if e == value

      i += 1
    end
  end

  def to_s
    msg = ''
    each do |value|
      msg += "( #{value} ) -> "
    end
    msg += 'nil'
  end
end

# nodes for containing linked lists
class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    @value.nil? ? 'nil' : @value
  end
end

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
