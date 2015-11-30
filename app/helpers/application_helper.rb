module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def yield_or_default(section, default = '')
    content_for?(section) ? content_for(section) : default
  end

  def style_for_cell(x, y)
    style = []
    @maze.sequence.each do |step_in_sequence|
      set_style_from_step(style, step_in_sequence, x, y)
    end
    style.join
  end

  def set_style_from_step(style, step_in_sequence, x, y)
    direction = direction_from_step(step_in_sequence.keys)
    position = position_from_step(step_in_sequence.keys)
    style << border_from(direction) if position == [x, y]

    direction = direction_from_step(step_in_sequence.values)
    position = position_from_step(step_in_sequence.values)
    style << border_from(direction) if position == [x, y]
  end

  def position_from_step(step_in_sequence)
    [step_in_sequence.first[0], step_in_sequence.first[1]]
  end

  def direction_from_step(step_in_sequence)
    step_in_sequence.first[2]
  end

  def border_from(direction)
    case direction
    when :U
      'border-top: 0;'
    when :D
      'border-bottom: 0;'
    when :L
      'border-left: 0;'
    when :R
      'border-right: 0;'
    end
  end

  def show_solution
    solution = []
    @maze.solution.each do |direction|
      solution << direction_text_from(direction)
    end
    solution.join ' -> '
  end

  def direction_text_from(direction)
    case direction
    when :U
      'Up'
    when :D
      'Down'
    when :L
      'Left'
    when :R
      'Right'
    end
  end
end
