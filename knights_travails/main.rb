require 'benchmark/ips'

# chess board
class ChessBoard
  # each "square" on a chess board
  class Vector2
    attr_accessor :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def +(other)
      Vector2.new(@x + other.x, @y + other.y)
    end

    def ==(other)
      other.x == @x && other.y == @y
    end

    def in_bounds?
      @x >= 0 && @y >= 0 && @x <= 7 && @y <= 7
    end
  end

  class Square
    attr_accessor :x, :y, :from, :to

    def initialize(x, y)
      @x = x
      @y = y
      @from = nil
      @to = nil
    end

    def reverse
      path = [self]
      path << path.last.from while path.last.from

      new_pos = Square.new(path.first.x, path.first.y)
      pos = new_pos
      (1..(path.length - 1)).each do |i|
        pos.to = path[i]
        pos = pos.to
      end
      new_pos
    end

    def to_s
      (@from ? "#{@from} -> " : '') + "(#{@x}, #{@y})" + (@to ? " -> #{@to}" : '')
    end

    def +(other)
      Square.new(@x + other.x, @y + other.y)
    end

    def ==(other)
      other.x == @x && other.y == @y
    end

    def in_bounds?
      @x >= 0 && @y >= 0 && @x <= 7 && @y <= 7
    end
  end

  def initialize
    @squares = build_squares
    @knight_directions = [
      Vector2.new(-1, 2),
      Vector2.new(1, 2),
      Vector2.new(2, 1),
      Vector2.new(2, -1),
      Vector2.new(1, -2),
      Vector2.new(-1, -2),
      Vector2.new(-2, -1),
      Vector2.new(-2, 1)
    ].freeze
    # @knight_directions = [
    #   [-1, 2],
    #   [1, 2],
    #   [2, 1],
    #   [2, -1],
    #   [1, -2],
    #   [-1, -2],
    #   [-2, -1],
    #   [-2, 1]
    # ].freeze
    # @knight_directions = [
    #   Square.new(-1, 2),
    #   Square.new(1, 2),
    #   Square.new(2, 1),
    #   Square.new(2, -1),
    #   Square.new(1, -2),
    #   Square.new(-1, -2),
    #   Square.new(-2, -1),
    #   Square.new(-2, 1)
    # ].freeze
  end

  def knight_moves(start_pos, end_pos)
    return start_pos, 0 if start_pos == end_pos

    steps = 0
    queue = [Vector2.new(start_pos[0], start_pos[1])]

    visited = Array.new(8) { Array.new(8, nil) }
    visited[start_pos[0]][start_pos[1]] = true

    end_pos = Vector2.new(end_pos[0], end_pos[1])
    loop do
      steps += 1
      new_queue = []
      queue.each do |pos| # |pos_x, pos_y|
        return pos, steps if pos == end_pos

        # return [pos_x, pos_y], steps if pos_x == end_pos[0] && pos_y == end_pos[1]

        @knight_directions.each do |offset|
          # new_x = pos_x + x
          # new_y = pos_y + y # (pos + offset)
          # next if !new_pos.in_bounds? || visited.include?(new_pos)
          new_pos = pos + offset # Vector2.new(pos_x + x, pos_y + y)
          x = new_pos.x
          y = new_pos.y
          next if !new_pos.in_bounds? || visited[x][y]

          # next if   (new_x.negative? || new_x > 7 || new_y.negative? || new_y > 7) || visited[new_x][new_y]

          new_queue << new_pos # [new_x, new_y]
          visited[x][y] = true
          # new_queue << new_pos
          # visited << new_pos
          # new_pos[2] = pos
        end
      end

      queue = new_queue
    end
  end

  def in_bounds?(pos)
    pos[0] >= 0 && pos[1] >= 0 && pos[0] <= 7 && pos[1] <= 7
  end

  private

  def build_squares
    squares = []
    8.times do |x|
      8.times do |y|
        squares << Square.new(x, y)
      end
    end

    squares
  end
end

board = ChessBoard.new
moves, steps = board.knight_moves([3, 3], [7, 7])
puts moves
puts steps
puts 'NEXT'
# puts board.knight_moves(ChessBoard::Square.new(3, 3), ChessBoard::Square.new(7, 7))
# puts board.knight_moves(ChessBoard::Square.new(3, 3), ChessBoard::Square.new(4, 3))
# puts board.knight_moves(ChessBoard::Square.new(3, 3), ChessBoard::Square.new(0, 0))

Benchmark.ips do |testcase|
  testcase.report('calculate knight moves') do
    board.knight_moves([3, 3], [7, 7])
  end
end
