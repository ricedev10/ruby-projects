require_relative 'lib/dictionary'
require_relative 'lib/hangman'

words = Dictionary.new(File.open('./assets/words.txt')) do |line|
  (5..12).include?(line.chomp.length)
end

answer = words.random_word
game = Hangman.new(answer)
