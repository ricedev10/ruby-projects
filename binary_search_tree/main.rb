# nodes for a binary search tree
class Node
  attr_accessor :data, :left, :right

  def initialize(value, left, right)
    @left = left
    @right = right
    @data = value
  end

  def children
    [@left, @right]
  end
end

class Tree
  attr_reader :root

  def initialize(elements)
    @root = build_tree(elements.uniq.sort)
  end

  def build_tree(elements, start_at = 0, end_at = elements.length)
    mid = (start_at + end_at) / 2
    return nil if start_at > end_at || elements[mid].nil?

    Node.new(
      elements[mid],
      build_tree(elements, start_at, mid - 1),
      build_tree(elements, mid + 1, end_at)
    )
  end

  def insert(value, node = @root)
    if value < node.data
      node.left ? insert(value, node.left) : node.left = Node.new(value, nil, nil)
    else
      node.right ? insert(value, node.right) : node.right = Node.new(value, nil, nil)
    end
  end

  def find(value, node = @root)
    return nil if node.nil?
    return find(value, node.left) if value < node.data
    return find(value, node.right) if value > node.data

    node
  end

  def delete(value, node = @root)
    return node if node.nil? # leaf node to delete

    # right subtree
    node.right = delete(value, node.right) and return node if value > node.data

    # left subtree
    node.left = delete(value, node.left) and return if value < node.data

    # delete THIS node
    return node.left if node.right.nil? # one/zero child
    return node.right if node.left.nil? # one/zero child

    # two child
    successor = get_successor(node)
    node.data = successor.data
    node.right = delete(successor.data, node.right)

    node
  end

  def get_successor(node)
    # the leftmost node on the right subtree
    successor = node.right
    successor = successor.left while successor.left
    successor
  end

  def level_order
    nodes_queue = [@root]
    while nodes_queue.length.positive?
      new_queue = []
      nodes_queue.each do |node|
        yield node
        new_queue << node.left if node.left
        new_queue << node.right if node.right
      end
      nodes_queue = new_queue
    end
  end

  def level_order_recursive(queue = [@root], &block)
    new_queue = []
    queue.each do |node|
      block.call(node)
      new_queue << node.left if node.left
      new_queue << node.right if node.right
    end

    level_order_recursive(new_queue, &block) unless new_queue.empty?
  end

  def preorder(node = @root, &block)
    # value, left, right
    yield node
    preorder(node.left, &block) if node.left
    preorder(node.right, &block) if node.right
  end

  def inorder(node = @root, &block)
    # left, value, right
    inorder(node.left, &block) if node.left
    yield node
    inorder(node.right, &block) if node.right
  end

  def postorder(node = @root, &block)
    # left, right, value
    postorder(node.left, &block) if node.left
    postorder(node.right, &block) if node.right
    yield node
  end

  def height(queue = [@root], depth = 0)
    return depth if queue.empty?

    new_queue = []
    queue.each do |node|
      new_queue << node.left if node.left
      new_queue << node.right if node.right
    end

    height(new_queue, depth + 1)
  end

  def to_s
    pretty_print(@root)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

new_tree = Tree.new([0, 1, 3, 4, 5, 6, 7])
new_tree.pretty_print

new_tree.level_order do |node|
  p node.data
end
puts '----'
new_tree.level_order_recursive do |node|
  p node.data
end
puts '-----'
new_tree.preorder do |node|
  puts node.data
end
p "depth: #{new_tree.height}"
