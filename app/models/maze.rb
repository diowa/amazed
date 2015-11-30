class Maze
  DIRECTIONS = [:U, :D, :R, :L]
  OPPOSITE   = { U: :D, D: :U, R: :L, L: :R }

  attr_reader :sequence, :solution, :width, :height, :initial_x, :initial_y, :final_x, :final_y

  def initialize(width = 10, height = 10)
    @width  = width
    @height = height
    @grid = Array.new(height) { Array.new(width, false) }
    @sequence = []
    @solution = []
  end

  def construct_and_solve(initial_x = 0, initial_y = 0, final_x = 9, final_y = 9)
    @initial_x = initial_x
    @initial_y = initial_y
    @final_x = final_x
    @final_y = final_y
    @solution_found = false
    mark_point_visited @initial_x, @initial_y
    carve_passages_from @initial_x, @initial_y
  end

  private

  def carve_passages_from(current_x, current_y)
    DIRECTIONS.shuffle.each do |direction|
      next_x, next_y = next_position(current_x, current_y, direction)
      next unless point_inside_grid?(next_x, next_y) && point_not_visited?(next_x, next_y)
      @solution << direction unless @solution_found
      @solution_found = true if ending_point?(next_x, next_y)
      mark_point_visited next_x, next_y
      @sequence << { [current_x, current_y, direction] => [next_x, next_y, OPPOSITE[direction]] }
      carve_passages_from next_x, next_y
      @solution.pop unless @solution_found
    end
  end

  def point_inside_grid?(x, y)
    y.between?(0, height - 1) && x.between?(0, width - 1)
  end

  def point_not_visited?(x, y)
    @grid[y][x] == false
  end

  def mark_point_visited(x, y)
    @grid[y][x] = true
  end

  def ending_point?(x, y)
    x == @final_x && y == @final_y
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
