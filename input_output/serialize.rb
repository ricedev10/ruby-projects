require 'yaml'

class A
  def initialize(string, number)
    @string = string
    @number = number
  end

  def to_s
    "In A:\n  #{@string}, #{@number}\n"
  end
end

class B
  def initialize(number, a_object)
    @number = number
    @a_object = a_object
  end

  def to_s
    "In B:\n   #{@number}, #{@a_object}\n"
  end
end

class C
  def initialize(b_object, a_object)
    @a_object = a_object
    @b_object = b_object
  end

  def to_s
    "In C:\n   #{@a_object}, #{@b_object}\n"
  end
end

a = A.new('Hello, world!', 12)
b = B.new(101, a)
c = C.new(a, b)

puts a
data = Marshal.dump(a)
p data
obj = Marshal.load(data)
p obj

File.open('object.yaml', 'w') do |file|
  (1..10).each do |i|
    file.puts YAML.dump(A.new('hello, world!', i))
    file.puts ''
  end
end

# a person
class Person
  def self.deserialize(data)
    args = YAML.load(data)
    new(args[:name], args[:age])
  end

  def initialize(name, age)
    @name = name
    @age = age
  end

  def serialize
    YAML.dump({
                name: @name,
                age: @age
              })
  end
end

kai = Person.new('Kai', 18)
p kai

packet = kai.serialize
p packet
new_kai = Person.deserialize(packet)
p new_kai
