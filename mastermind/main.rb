# frozen_string_literal: true

require 'colorize'

MAX_ROUNDS = 12
COLORS = %i[blue red yellow magenta green]

class Keypad
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def correct_digits(code)
    sum = 0
    @code.each_index { |i| sum += 1 if @code[i] == code[i] }
    sum
  end

  def contains_digits(code)
    contains = 0

    i = -1
    leftover = @code.map do |digit|
      i += 1
      digit if digit != code[i]
    end

    added = []
    code.each_index do |i|
      digit = code[i]
      if leftover.any?(digit) && !leftover[i].nil? && added.count(digit) < @code.count(digit)
        contains += 1
        added << digit
      end
    end
    #
    # blue red blue magenta
    # red  red.red.  red
    # red ___ red   red
    #
    # . magenta blue magenta yellow
    #
    #
    # yellow. yellow green yellow
    # yellow yellow yellow magenta
    # ____ _______.  green yellow

    contains
  end
end

class ColorKeypad < Keypad
  def initialize(colors)
    @colors = colors
    @rng = Random.new

    p super generate_new_code
  end

  def generate_new_code
    Array.new(4) { |_| @colors[@rng.rand(@colors.count) - 1] }
  end
end

class Mastermind
  attr_accessor :rounds_played

  def initialize(colors, max_rounds)
    @color_keypad = ColorKeypad.new(colors)
    @max_rounds = max_rounds
    @rounds_played = 0
  end

  def play_round(code)
    return nil if @rounds_played > @max_rounds

    @rounds_played += 1
    correct = @color_keypad.correct_digits(code)
    contains = @color_keypad.contains_digits(code)

    [correct, contains]
  end
end

class Guess
  attr_reader :name

  def initialize(name, colors, count)
    @name = name
    @colors = colors
    @count = count
  end

  def guess
    Array.new(@count) { |_| @colors[@rng.rand(@colors.count) - 1] }
  end
end

class Player < Guess
  def guess
    loop do
      print('Enter a guess: ')
      code = gets.chomp!.split(' ').map!(&:to_sym)
      return code if code.count == @count && code.all? { |ele| @colors.any?(ele) }
    end
  end
end

class Computer < Guess
  attr_reader :name

  def initialize(name, colors, count)
    @guesses = []
    @rng = Random.new
    @colors = colors

    super
  end

  def guess
    new_guess = Array.new(4, @colors.first)

    @guesses << new_guess
    new_guess
  end
end

def play(code_count, max_rounds, colors)
  puts 'Welcome to mastermind!'
  puts 'Guess a 4 color code that consists of the following colors:'
  puts colors.map(&:to_s).join(' ')
  print "\nEnter player name: "
  client = Player.new(gets.chomp!, colors, code_count)
  ai = Computer.new('AI', colors, code_count)
  game = Mastermind.new(colors, max_rounds)

  loop do
    plr = client
    guess = plr.guess

    round = game.play_round(guess)
    if round.nil?
      puts "You lose #{plr.name}! Too many tries"
      break
    end

    puts "#{'Correct'.colorize(:green)}: #{round[0]} | #{'Contains'.colorize(:yellow)} #{round[1]}"

    # check if player won the match
    if round[0] == code_count && round[1] == 0
      puts "You won #{plr.name}! Congratulations!"
      break
    end
  end
end

play(4, MAX_ROUNDS, COLORS)
