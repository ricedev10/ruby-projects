require 'benchmark/ips'

class ChessBoard
  def initialize
    @knight_directions = [
      [-1, 2], # top left
      [1, 2], # top right
      [2, 1], # right top
      [2, -1], # right bottom
      [1, -2], # bottom right
      [-1, -2], # bottom left
      [-2, -1], # left bottom
      [-2, 1] # left top
    ].freeze
  end

  def knight_moves(start_pos, end_pos)
    traversed_positions = Array.new(8) { Array.new(8, nil) }

    end_x = end_pos[0]
    end_y = end_pos[1]

    queue = [start_pos]
    steps = 0
    loop do
      pos = queue.shift
      @knight_directions.each do |offset_x, offset_y|
        x = pos[0] + offset_x
        next unless x >= 0 && x <= 7

        y = pos[1] + offset_y
        next unless y >= 0 && y <= 7

        next if traversed_positions[x][y] # skip if already moved to position
        pos[2] = end_pos and return pos if end_x == x && end_y == y

        traversed_positions[x][y] = true # mark traversed
        queue << [x, y, pos]
      end

      steps += 1
    end
  end

  def in_bounds?(x, y)
    x >= 0 && y >= 0 && x <= 7 && y <= 7
  end
end

board = ChessBoard.new
moves = board.knight_moves([0, 0], [7, 7])
directions = ''
while moves
  directions = "(#{moves[0]}, #{moves[1]})" +
               (directions.empty? ? '' : ' -> ') + directions
  moves = moves[2]
end
puts directions

Benchmark.ips do |testcase|
  testcase.report('new') do
    board.knight_moves([0, 0], [7, 7])
  end
end
