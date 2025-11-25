require_relative 'buckets'
require_relative 'node'

# Custom implementation of a hash in ruby
class HashMap
  # Question: Why don't we just use arrays instead of LinkedLists? How much
  # more performant (in speed/memory) are arrays compared to a ruby
  # implementation of LinkedLists?
  attr_reader :length

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Buckets.new
    @length = 0
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

    add_to_bucket(bucket, key, value)

    grow_buckets if @length > (@load_factor * @capacity)
  end

  def keys
    all_keys = []
    each_node do |node|
      all_keys << node.key
    end

    all_keys
  end

  def values
    all_values = []
    each_node do |node|
      all_values << node.value
    end

    all_values
  end

  def entries
    all_entries = []
    each_node do |node|
      all_entries << [node.key, node.value]
    end
    all_entries
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

  def remove(key)
    index = hash(key) % @capacity
    bucket = @buckets.get_at(index)
    return nil if bucket.nil?

    bucket.each_index do |index|
      bucket.delete_at(index) and @length -= 1 and break if bucket[index].key == key
    end
  end

  def clear
    @buckets.clear
    @length = 0
  end

  def grow_buckets
    @capacity *= 2
  end

  def to_s
    msg = "{\n"
    @buckets.each do |bucket|
      bucket.each do |node|
        msg += "  #{node.key} = #{node.value}\n"
      end
    end

    msg += '}'
  end

  private

  def add_to_bucket(bucket, key, value)
    added_key = false
    bucket.each do |node|
      if node.key == key
        node.value = value
        added_key = true
      end
    end
    bucket << Node.new(key, value) and @length += 1 unless added_key
  end

  def each_node(&block)
    @buckets.each do |bucket|
      bucket.each(&block)
    end
  end
end
