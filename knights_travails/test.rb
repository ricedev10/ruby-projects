require 'benchmark/ips'

class ChessBoard
  KNIGHT_DIRS = [
    [-1, 2], [1, 2], [2, 1], [2, -1],
    [1, -2], [-1, -2], [-2, -1], [-2, 1]
  ].freeze

  def knight_moves(start_pos, end_pos)
    sx, sy = start_pos
    ex, ey = end_pos

    return [start_pos], 0 if sx == ex && sy == ey

    visited = Array.new(8) { Array.new(8, false) }
    parent  = Array.new(8) { Array.new(8) }

    queue = [[sx, sy]]
    visited[sx][sy] = true

    steps = 0

    loop do
      next_queue = []

      queue.each do |x, y|
        return [reconstruct_path([x, y], parent), steps] if x == ex && y == ey

        KNIGHT_DIRS.each do |dx, dy|
          nx = x + dx
          ny = y + dy

          next if nx < 0 || ny < 0 || nx > 7 || ny > 7
          next if visited[nx][ny]

          visited[nx][ny] = true
          parent[nx][ny]  = [x, y]
          next_queue << [nx, ny]
        end
      end

      queue = next_queue
      steps += 1
    end
  end

  private

  def reconstruct_path(end_xy, parent)
    path = []
    x, y = end_xy

    while x && y
      path << [x, y]
      x, y = parent[x][y]
    end

    path.reverse
  end
end

board = ChessBoard.new

Benchmark.ips do |t|
  t.report('optimized knight moves') do
    board.knight_moves([3, 3], [7, 7])
  end
end
