# frozen_string_literal: true

require 'colorize'

MAX_ROUNDS = 12
COLORS = %i[blue red yellow magenta green black]

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
    leftover = negate_code(code)
    added = []

    contains = 0
    code.each_index do |i|
      digit = code[i]
      if leftover.any?(digit) && !leftover[i].nil? && added.count(digit) < @code.count(digit)
        contains += 1 and added << digit
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

  private

  def negate_code(code)
    leftover = Array.new(@code.count, nil)
    leftover.each_index do |i|
      i += 1
      leftover[i] = @code[i] if @code[i] != code[i]
    end
    leftover
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

  def receive_guess(last_guess, correct, contains) end
end

class Player < Guess
  def guess
    loop do
      print('Enter a guess: ')
      code = gets.chomp!.split(' ').map!(&:to_sym)
      return code if code.count == @count && code.all? { |ele| @colors.any?(ele) }
    end
  end

  def receive_guess(_last_guess, correct, contains)
    puts "#{'Correct'.colorize(:green)}: #{correct} | #{'Contains'.colorize(:yellow)} #{contains}"
  end
end

class Computer < Guess
  attr_reader :name

  def initialize(name, colors, count)
    @guesses = []
    @rng = Random.new
    @colors = colors
    @combinations = permutations(count)
    @next_guess = [@colors.first, @colors.first, @colors[1], @colors[1]]
    @must_have = {}

    super
  end

  def guess
    # Create the set S of 1,296 possible codes {1111, 1112, ... 6665, 6666}.
    # Start with initial guess 1122.[a]
    # Play the guess to get a response of colored and white key pegs.
    # If the response is four colored key pegs, the game is won, the algorithm terminates.
    # Otherwise, remove from S any code that would not give that response of colored and white pegs.
    # The next guess is chosen by the minimax technique, which chooses a guess that has the least worst response score. In this case, a response to a guess is some number of colored and white key pegs, and the score of a response is defined to be the number of codes in S that are still possible even after the response is known. The score of a guess is pessimistically defined to be the worst (maximum) of all its response scores. From the set of guesses with the best (minimum) guess score, select one as the next guess, choosing a code from S whenever possible.[b][c] # rubocop:disable Layout/LineLength
    # Repeat from Step 3.
    #
    @next_guess
  end

  def receive_guess(guess, correct, contains)
    p guess
    p @combinations.count
    p "contains #{contains}, correct: #{correct}"
    @combinations.delete_at(0)
    if correct.positive? || contains.positive?
      # remove all combinations that do not contain the guess colors
      @combinations.select! do |combo|
        combo.intersect?(guess)
      end
      p @combinations.count
      p 'uh oh'
    elsif correct.zero? && contains.zero?
      # remove all combinations that DO contain the guess colors
      @combinations.reject! do |combo|
        combo.intersect?(guess)
      end
      p @combinations.count
      p(correct, contains)
      p 'nope!'
    end

    # if correct.positive? && contains.zero?
    #   if guess.all?(guess.first)
    #     # remove all combinations that don't have exactly the correct many
    #     @combinations.select! do |combo|
    #       combo.count(guess.first) == correct
    #     end
    #     @must_have[guess.first] = correct
    #   else
    #     # remove combinations that don't exactly match
    #     uniq = guess.uniq
    #     if correct == 2
    #       @combinations.select! do |combo|
    #         combo.count(uniq[0]) == 2 || combo.count(uniq[1]) == 2
    #       end
    #     else
    #       @combinations.select! do |combo|
    #         has = true
    #         uniq.each do |e|
    #           has = false if combo.count(e) < correct
    #         end
    #         has
    #       end
    #     end

    # remove all combinations that don't match what must be contained
    #     @combinations.select! do |combo|
    #       has = true
    #       @must_have.each do |key, value|
    #         has = false if combo.count(key) != value
    #       end
    #       has
    #     end
    #   end
    # end

    @combinations.compact!
    p @combinations.count
    @next_guess = @combinations.first
  end

  private

  def permutations(count)
    possibilities = []
    @colors.repeated_permutation(count) do |perm|
      possibilities.push(perm)
    end

    possibilities
  end
end

def play(code_count, max_rounds, colors, played)
  played += 1
  return if played > 50

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
      play(code_count, max_rounds, colors, played)
      break
    end

    plr.receive_guess(guess, round[0], round[1])

    # check if player won the match
    next unless round[0] == code_count && round[1].zero?

    puts "You won #{plr.name}! Congratulations! It took #{game.rounds_played} tries." # okay
    # play(code_count, max_rounds, colors, played)
    break
  end
end

play(4, MAX_ROUNDS, COLORS, 0)
