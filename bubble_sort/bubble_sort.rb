def quick_sort(numbers)
  for i in 0..(numbers.length - 2)
    num = numbers[i]
    next_num = numbers[i + 1] || 0
    (numbers[i], numbers[i + 1] = next_num, num) if (num > next_num)
  end
end

def bubble_sort(numbers)
  for _ in 0..(numbers.length - 1)
    quick_sort(numbers)
  end

  numbers
end

p bubble_sort([4,3,78,2,0,2])