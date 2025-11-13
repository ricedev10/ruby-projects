# frozen_string_literal: true

# for creating tic-tac-toe games
class TicTacToe
  def initialize
    @boxes = Array.new(9, nil) # fills row first, then down to next column
  end

  def score_point(row, column, point)
    index = (row * 3) + column
    return false if @boxes[index]

    @boxes[index] = point
    true
  end

  def find_winner
    # find straight patterns
    patterns = rows.union(columns).union(crosses)
    patterns.each do |row|
      return true if row.all?(1) || row.all?(0)
    end

    false
  end

  def clean_board
    @boxes = Array.new(9, nil)
  end

  def to_s
    board = ''
    rows.each do |row|
      board += "#{to_xo(row[0])} | #{to_xo(row[1])} | #{to_xo(row[2])}\n"
    end

    board.chomp
  end

  private

  def to_xo(value)
    case value
    when 1
      'x'
    when 0
      'o'
    else
      '-'
    end
  end

  def rows
    [
      @boxes.slice(0, 3),
      @boxes.slice(3, 3),
      @boxes.slice(6, 3)
    ]
  end

  def columns
    # rubocop: disable Styles/For
    columns = []
    for i in 0..2
      columns << [
        @boxes[i],
        @boxes[i + 3],
        @boxes[i + 6]
      ]
    end
    # rubocop: enable Styles/For

    columns
  end

  def crosses
    [
      [@boxes[0], @boxes[4], @boxes[8]],
      [@boxes[2], @boxes[4], @boxes[6]]
    ]
  end
end
