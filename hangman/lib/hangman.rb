class Hangman
  def initialize(word)
    @word = word.downcase
    @guesses = []
  end

  def guess_letter(letter)
    @guesses << letter.downcase
  end

  def guess_word(word)
    @guesses << word.downcase
  end

  def status
    response = []
    @word.split('').each do |char|
      response << (@guesses.include?(char) ? char : '_') << ' '
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
