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
    @length += 1 if @array[index].nil? && !value.index.nil?
    @length -= 1 if value.nil? && !@array[index].nil?
    @array[index] = value
    value
  end

  def remove_at(index)
    @length -= 1 unless @array[index].nil?
    @array[index] = nil
  end

  def each
    @array.each do |value|
      yield(value) unless value.nil?
    end
  end

  def clear
    @array.clear
    @length = 0
  end
end
