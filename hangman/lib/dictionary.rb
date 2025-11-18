class Dictionary
  attr_reader :words

  def initialize(file, &filter_word)
    @words = []
    @rng = Random.new

    until file.eof?
      line = file.readline
      @words << line.chomp if filter_word.call(line)
    end
  end

  def random_word
    @words[@rng.rand(0..(@words.count))]
  end
end
