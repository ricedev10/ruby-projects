class MyCar
  attr_accessor :model, :color, :miles
  attr_reader :year

  def initialize(speed)
    @speed = speed
  end

  def brake(amount)
    @speed -= amount
  end

  def speed_up(amount)
    @speed += amount
  end

  def turn_engine_off
    @speed = 0
  end

  def spray_paint(color)
    @color = color
  end

  def self.gas_mileage(gallons, miles)
    miles / gallons
  end
end

lambo = MyCar.new(89)
lambo.model = "Lambo"
lambo.color = "yellow"
lambo.year

p lambo
lambo.brake(5)
p lambo
lambo.speed_up(100)
p lambo
lambo.turn_engine_off
p lambo
lambo.spray_paint("green")
p lambo
p MyCar.gas_mileage(10, 5)