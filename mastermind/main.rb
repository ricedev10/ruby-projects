require 'colorize'

COLORS = %i[
  black red green yellow blue magenta white
]

# create random combinations of specified length and values
class Keypad
  attr_reader :combo, :count, :values

  def initialize(count, values)
    @count = count
    @values = values
    @rng = Random.new
    @combo = new_combo
  end

  def new_combo
    @combo = Array.new(@count) { @values[@rng.rand(@values.count)] }
  end

  def guess(*combo)
    combo == @combo
  end
end

class Mastermind
  def initialize(count, colors)
    @keypad = Keypad.new(count, colors)
    @colors = colors
  end

  def combo
    @keypad.combo
  end

  def match(*values)
    @keypad.guess(*values)
  end

  def gets_guess
    loop do
      print "\rEnter a guess: "
      out = gets.chomp!.split(' ')
      if (out.count == @keypad.count) && out.all? { |value| @keypad.values.any?(value.to_sym) }
        return out.map(&:to_sym) # { |value| value.to_sym }
      end
    end
  end

  def output_guess(guess)
    output = ''
    i = 0
    correct = true
    guess.each do |value|
      color = if value == combo[i]
                :green
              elsif combo.any?(value)
                correct = false
                :yellow
              else
                correct = false
                :red
              end
      output << "#{value.to_s.colorize(color)} "
      i += 1
    end

    puts output
    correct
  end

  def start
    puts 'Welcome to mastermind!'
    puts "Colors: #{@colors}"
    loop do
      guess = gets_guess
      correct = output_guess(guess)

      next unless correct

      puts 'You guessed right! Yay!'
      break unless play_again

      @keypad.new_combo
    end
  end

  def play_again
    loop do
      print "\nPlay again? (y/n): "
      play_again = gets.chomp!
      if play_again == 'y'
        return true
      elsif play_again == 'n'
        return false
      end
    end
  end
end

new_game = Mastermind.new(4, COLORS)
new_game.start
