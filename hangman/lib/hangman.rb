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

    return true if response.join == @word

    response.join
  end

  def incorrect
    incorrect = []
    @guesses.each do |char|
      incorrect << char unless @word.match?(char)
    end

    incorrect
  end
end
