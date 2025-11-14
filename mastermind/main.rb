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
    leftover = code.map do |digit|
      i += 1
      digit if digit != @code[i]
    end

    @code.each_index do |i|
      (contains += 1) if leftover.any?(@code[i]) && !leftover[i].nil?
    end

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

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_guess(msg, check)
    loop do
      print(msg)
      guess = check.call(gets)
      return guess if guess
    end
  end
end

class Computer
  def initialize
  end
end

def play(code_count, max_rounds, colors)
  print "\nEnter player name: "
  plr = Player.new(gets.chomp!)
  game = Mastermind.new(colors, max_rounds)

  loop do
    guess = plr.get_guess(
      'Enter a guess: ',
      lambda { |msg|
        code = msg.split(' ').map!(&:to_sym)
        code if code.count == code_count && code.all? { |ele| colors.any?(ele) }
      }
    )

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
