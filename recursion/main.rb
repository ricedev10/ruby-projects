class RecursionExamples
  def initialize
    @roman_mapping = {
      1000 => 'M',
      900 => 'CM',
      500 => 'D',
      400 => 'CD',
      100 => 'C',
      90 => 'XC',
      50 => 'L',
      40 => 'XL',
      10 => 'X',
      9 => 'IX',
      5 => 'V',
      4 => 'IV',
      1 => 'I'
    }
  end

  def int_to_roman(int, *keys)
    total = 0
    keys.each { |num| total += num }
    if total == int
      numeral = ''
      keys.each do |key|
        numeral += @roman_mapping[key]
      end

      numeral
    else
      comparison = int
      keys.each { |num| comparison -= num }

      greatest = 1
      @roman_mapping.each_key do |key|
        greatest = key if key >= greatest && key <= comparison
      end

      keys << greatest

      int_to_roman(int, *keys)
    end
  end

  def roman_to_int(roman, result = 0)
    return result if roman.empty?

    @roman_mapping.each_key do |num|
      char = @roman_mapping[num]
      return roman_to_int(roman.slice(char.length..(-1)), result + num) if roman.start_with?(char)
    end
  end

  def fibs(num)
    sequence = [0, 1]
    (1..(num - 2)).each do |i|
      sequence << sequence[i] + sequence[i - 1]
    end
    sequence
  end
end

rec = RecursionExamples.new
p rec.fibs(8)
