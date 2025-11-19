require 'io/console'
require_relative 'lib/dictionary'
require_relative 'lib/hangman'
require_relative 'lib/save'

App.new

# start a hangman game, save games and load previous saves
class App
  def initialize
    @saves = Save.new File.join(File.dirname(__FILE__), 'saves')

    words_file = File.open(File.join(File.dirname(__FILE__), './assets/words.txt'))
    @words = Dictionary.new(words_file) do |line|
      (5..12).include?(line.chomp.length)
    end
    @game = Hangman.new(new_word)

    puts 'Welcome to hangman!'
    puts 'Press 1 to play'
    puts 'Press 2 to load game'

    case integer_input(1..2)
    when 1
      play_game
    when 2
      load_game
      play_game
    end
  end

  def new_word
    @words.random_word
  end

  def integer_input(range)
    loop do
      int = gets.chomp.to_i
      return int if range.include?(int)
    end
  end

  def play_game
    puts 'Enter a letter or word to start guessing'
    puts 'Enter 1 at any time to save'
    puts 'Enter 0 at any time to exit'

    loop do
      input = gets.chomp
      if input == '1'
        @saves.add_save(@game.data)
        @saves.serialize
      end
      if input.length == 1
        @game.guess_letter(input)
      else
        @game.guess_word(input)
      end
      status = @game.status

      puts status
      puts "Attempts: #{@game.attempts}"
      puts "Guessed: #{@game.incorrect}"
      (puts 'You won!' and break) if @game.won?
    end
  end

  def load_game
    @saves.saves.each_index do |i|
      puts "Enter #{i} to load save #{i}"
    end

    save_file = integer_input(0..@saves.saves.count)
    data = @saves.saves[save_file]
    @game.load(data)
  end
end
