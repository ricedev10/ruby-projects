class Hangman
  def initialize(word)
    @word = word.downcase
    @guesses = []
  end

  def guess(letter)
    @guesses << letter.downcase

    response = []
    @word.split('').each do |char|
      response << (@guesses.include?(char) ? char : '_') << ' '
    end

    response.join
  end
end
