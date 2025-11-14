# frozen_string_literal: true

require 'colorize'

class Keycode
  def initialize(code)
    @code = code
  end

  def correct(code)
    values = Array.new(@code.count, false)
    @code.each_index do |index|
      values[index] = true if @code[index] == code[index]
    end

    values
  end

  def contains(code)
    digits = []
    code.each_index do |index|
      digit = code[index]
      (digits << digit) if @code.any?(digit) && digits.count(digit) < @code.count(digit)
    end

    digits
  end
end

code = Keycode.new(%i[red yellow yellow red])
guess = %i[blue red red red]

correct = code.correct(guess)
contains = code.contains(guess)

p correct
p contains
output = Array.new(4, nil)
guess.each_index do |i|
  color = if correct[i]
            contains[contains.find_index(guess[i])] = nil
            :green
          else
            :white
          end
  output[i] = guess[i].to_s.colorize(color)
end

p contains
guess.each_index do |i|
  value = contains.find_index(guess[i])
  if value
    contains[value] = nil
    output[i] = guess[i].to_s.colorize(:yellow)
  end
end

puts output.join(' ')
