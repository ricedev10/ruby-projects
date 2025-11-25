require_relative 'linkedlist'

# Custom implementation of a hash in ruby
class HashMap
  # Question: Why don't we just use arrays instead of LinkedLists? How much
  # more performant (in speed/memory) are arrays compared to a ruby
  # implementation of LinkedLists?

  def initialize
    @capacity = 16
    @factor = 0.75
    @buckets = Array.new(@capacity, nil)
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

    @buckets[index] = value
  end
end

map = HashMap.new
map.set('Name', 'Kai')
