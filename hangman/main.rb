require 'io/console'
require_relative 'lib/dictionary'
require_relative 'lib/hangman'

words = Dictionary.new(File.open('./assets/words.txt')) do |line|
  (5..12).include?(line.chomp.length)
end

answer = words.random_word
game = Hangman.new(answer)

puts 'Welcome to hangman! Enter a letter to start guessing (also may enter words):'
puts game.status
loop do
  input = gets.chomp
  if input.length == 1
    game.guess_letter(input)
  else
    game.guess_word(input)
  end
  status = game.status

  puts status
  puts "Attempts: #{game.attempts}"
  puts "Guessed: #{game.incorrect}"
  if game.won?
    puts 'You won!'
    break
  end
end
