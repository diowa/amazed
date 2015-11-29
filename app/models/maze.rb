class Maze

  attr_reader :sequence, :width, :height

  DIRECTIONS = [:U, :D, :R, :L]
  OPPOSITE   = { :U => :D, :D => :U, :R => :L, :L => :R }

  def initialize(width = 10, height = 10)
    @width  = width
    @height = height
    @grid = Array.new(height) { Array.new(width, false) }
    @sequence = []
  end

  def construct(x = 0, y = 0)
    mark_visited x, y
    carve_passages_from x, y
  end

  private

  def carve_passages_from(current_x, current_y)
    DIRECTIONS.shuffle.each do |direction|
      next_x, next_y = next_position(current_x, current_y, direction)

      if inside_grid?(next_x, next_y) && not_visited?(next_x, next_y)
        mark_visited next_x, next_y
        @sequence.push({[current_x, current_y, direction] => [next_x, next_y, OPPOSITE[direction]]})
        carve_passages_from next_x, next_y
      end
    end
  end

  def inside_grid?(x, y)
    y.between?(0, height - 1) && x.between?(0, width - 1)
  end

  def not_visited?(x, y)
    @grid[y][x] == false
  end

  def mark_visited(x, y)
    @grid[y][x] = true
  end

  def next_position(x, y, direction)
    case direction
    when :U
      [x, y - 1]
    when :D
      [x, y + 1]
    when :L
      [x - 1, y]
    when :R
      [x + 1, y]
    end
  end
end
