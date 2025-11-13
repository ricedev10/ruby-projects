# frozen_string_literal: true

require_relative 'tic_tac_toe'

def get_position(msg)
  loop do
    print msg
    user_input = gets.chomp!

    if user_input =~ /^[0-9]+$/
      return user_input.to_i if new_row >= 1 && new_row <= 3

      puts 'Must be between 1 and 3'
    else
      puts 'Invalid number'
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

    play_again = ''
    loop do
      print "\nPlay again? "
      play_again = gets.chomp!.downcase
      break if %w[n y].include?(play_again)
    end
    break if play_again == 'n'
  end

  # alternate turns
  player_turn = player_turn == 1 ? 0 : 1
end
