# frozen_string_literal: true

require_relative 'tic_tac_toe'

def get_position(msg)
  loop do
    print msg
    user_input = gets.chomp!

    if user_input =~ /^[0-9]+$/
      new_row = user_input.to_i
      return new_row if new_row >= 1 && new_row <= 3

      puts 'Must be between 1 and 3'
    end

    puts 'Invalid number'
  end
end

def should_play_again
  loop do
    print "\nPlay again? (y/n) "
    play_again = gets.chomp!.downcase

    if play_again == 'y'
      return true
    elsif play_again == 'n'
      return false
    end
  end
end

game = TicTacToe.new
player_turn = 0
loop do
  puts 'Game Board:'
  puts game

  # get position where user wants to place X/O
  # make sure position is not already filled
  loop do
    row = get_position('Enter row: ')
    column = get_position('Enter column: ')

    break if game.score_point(row - 1, column - 1, player_turn)

    puts 'Spot already taken!'
  end

  # check if anyone has won
  winner = game.find_winner
  if winner
    puts "Congrats player #{player_turn == 1 ? 'x' : 'o'}!"
    puts 'Final game: '
    puts game

    break unless should_play_again
  end

  # alternate turns
  player_turn = player_turn == 1 ? 0 : 1
end
