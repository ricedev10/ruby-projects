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

  def fibs_rec(num, seq = [0, 1])
    return seq if seq.length == num

    seq << seq[-1] + seq[-2]
    fibs_rec(num, seq)
  end

  def merge_sort(array)
    half = (array.length / 2).floor
    left = array[0..(half - 1)]
    right = array[half..]

    left = merge_sort(left) if left.length > 1
    right = merge_sort(right) if right.length > 1

    merged = []
    left_i = 0
    right_i = 0
    loop do
      right_value = right[right_i]
      left_value = left[left_i]
      if right_value.nil?
        merged += left[left_i..]
        p merged
        break
      end
      if left_value.nil?
        merged += right[right_i..]
        p merged
        break
      end

      if left_value < right_value
        merged << left_value
        left_i += 1
      else
        merged << right_value
        right_i += 1
      end
    end

    merged
  end
end

rec = RecursionExamples.new
p rec.fibs(8)
p rec.fibs_rec(8)

arr = [4, 1, 5, 9, 129, 10, 10, 10, 9, 184, 13, 1]
merged = rec.merge_sort(arr)
p merged
p merged.length == arr.length
