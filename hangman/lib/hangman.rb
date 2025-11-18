class Hangman
  def initialize(word)
    @word = word.downcase
    @guesses = []
  end

  def guess(letter)
    @guesses << letter.downcase
  end

  def status
    response = []
    @word.split('').each do |char|
      response << (@guesses.include?(char) ? char : '_') << ' '
    end

    response.join
  end

  def incorrect_guesses
    response = []
    @word.split('').each do |char|
      response << (@guesses.include?(char) ? char : '_') << ' '
    end

    response.join
  end
end
