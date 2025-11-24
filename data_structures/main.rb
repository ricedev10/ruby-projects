# node class for binary trees
class Node
  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def depth_search(&block)
    block.call(@data) && return if @left.nil? && @right.nil?

    block.call(@data)
    @left&.depth_search(&block)
    @right&.depth_search(&block)
  end

  def breadth_search(&block)
  end
end

rootNode = Node.new(
  '1',
  Node.new('2', Node.new('3')),
  Node.new('c')
)

rootNode.depth_search do |data|
  p data
end
