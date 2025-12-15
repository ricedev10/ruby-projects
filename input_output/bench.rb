class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
end

class LinkedListWithNodeClass
  # Internal Node class
  class Node
    attr_accessor :value, :next

    def initialize(value)
      @value = value
      @next = nil
    end
  end

  def initialize
    @head = nil
  end

  def append(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      return @head
    end

    tail = @head
    tail = tail.next until tail.next.nil?
    tail.next = node
  end

  def find(value)
    node = @head
    until node.nil?
      break if node.value == value

      node = node.next
    end

    node
  end
end

class LinkedListWithArrayNodes
  def initialize
    @head = nil
  end

  def append(value)
    node = [value, nil]

    if @head.nil?
      @head = node
      return @head
    end

    tail = @head
    tail = tail[1] until tail[1].nil?
    tail[1] = node
  end

  def find(value)
    node = @head
    until node[1].nil?
      break if node[0] == value

      node = node[1]
    end

    node
  end
end

# TEST
require 'benchmark/ips'
require 'objspace'

# pre-allocated array of 1000 numbers
vals = 1_000.times.to_a
ll_node = LinkedListWithNodeClass.new
ll_arr = LinkedListWithArrayNodes.new

vals.each do |val|
  ll_node.append val
  ll_arr.append val
end

Benchmark.ips do |test_case|
  # find the last element of the linked lists
  test_case.report('with node class') { ll_node.find 999 }
  test_case.report('with array nodes') { ll_arr.find 999 }

  test_case.compare!
end

puts "Array mem footprint: #{ObjectSpace.memsize_of_all(Array) - ObjectSpace.memsize_of(vals)}"
puts "Node mem footprint: #{ObjectSpace.memsize_of_all(LinkedListWithNodeClass::Node)}"

puts ObjectSpace.memsize_of([1])         # 40
puts ObjectSpace.memsize_of(Node.new(1)) # 40
