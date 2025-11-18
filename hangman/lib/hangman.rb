require 'colorize'

# Hangman game; guess letters/words and keeps tracks of guesses
class Hangman
  def initialize(word)
    @word = word.downcase
    @guesses = []
  end

  def guess_letter(letter)
    @guesses << letter.downcase if @guesses.none?(letter)
  end

  def guess_word(word)
    @guesses << word.downcase if @guesses.none?(word)
  end

  def status
    response = []
    @word.split('').each do |char|
      response << (@guesses.include?(char) ? char.colorize(:green) : '_')
    end

    response.join
  end

  def won?
    return true if @guesses.any?(@word)

    @word.split('').each do |char|
      return false unless @guesses.any?(char)
    end
    true
  end

  def incorrect
    incorrect = []
    @guesses.each do |char|
      incorrect << char unless @word.match?(char)
    end

    incorrect
  end
end
