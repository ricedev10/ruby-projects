# stores key & value pairs
class Node
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end
