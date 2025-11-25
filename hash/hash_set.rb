require_relative 'buckets'

# Custom implementation of a hash in ruby
class HashSet
  # Question: Why don't we just use arrays instead of LinkedLists? How much
  # more performant (in speed/memory) are arrays compared to a ruby
  # implementation of LinkedLists?
  attr_reader :entries

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Buckets.new
    @entries = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key)
    hash_code = hash(key)
    index = hash_code % @capacity
    raise IndexError if index.negative? || index > @capacity

    bucket = @buckets.get_at(index) || @buckets.set_at(index, [])

    add_to_bucket(bucket, key)

    grow_buckets if @entries > (@load_factor * @capacity)
  end

  def keys
    all_keys = []
    @buckets.each do |keys|
      keys.each do |k|
        all_keys << k
      end
    end

    all_keys
  end

  def get(key)
    index = hash(key) % @capacity
    bucket = @buckets.get_at(index)
    return nil if bucket.nil?

    bucket.each do |v|
      return v if v == key
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
      bucket.delete_at(index) and @entries -= 1 and break if bucket[index] == key
    end
  end

  def clear
    @buckets.clear
    @entries = 0
  end

  def grow_buckets
    @capacity *= 2
  end

  def to_s
    msg = "{\n"
    keys.each do |key|
      msg += "  #{key}\n"
    end

    msg += '}'
  end

  private

  def add_to_bucket(bucket, key)
    return key if bucket.any? { |v| v == key }

    bucket << key
    @entries += 1
  end
end
