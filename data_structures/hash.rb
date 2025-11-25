require_relative 'linkedlist'

# Custom implementation of a hash in ruby
class HashMap
  # Question: Why don't we just use arrays instead of LinkedLists? How much
  # more performant (in speed/memory) are arrays compared to a ruby
  # implementation of LinkedLists?

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Buckets.new
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    hash_code = hash(key)
    index = hash_code % @capacity
    raise IndexError if index.negative? || index > @capacity

    bucket = @buckets.get_at(index) || @buckets.set_at(index, [])
    bucket << Node.new(key, value)

    p @buckets.length
    grow_buckets if @buckets.length > (@load_factor * @capacity)
  end

  def get(key)
    index = hash(key) % @capacity
    bucket = @buckets.get_at(index)
    return nil if bucket.nil?

    bucket.each do |node|
      return node.value if node.key == key
    end
    nil
  end

  def has?(key)
    !get(key).nil?
  end

  def grow_buckets
    puts 'TODO: Grow buckets'
  end
end

# Storing a "bucket" which can be anything (bucket is an array for HashMap)
class Buckets
  attr_reader :length

  def initialize
    @array = []
    @length = 0
  end

  def get_at(index)
    @array[index]
  end

  def set_at(index, value)
    @length += 1 if @array[index].nil?
    @length -= 1 if value.nil?
    @array[index] = value
    value
  end

  def remove_at(index)
    @length -= 1 if @array[index].nil?
    @array[index] = nil
  end
end

# stores key & value pairs
class Node
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

map = HashMap.new
map.set('Name', 'Kai')
p map.has?('Name')
p map.has?('name')
p map.get('Name')
