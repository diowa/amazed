module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def yield_or_default(section, default = '')
    content_for?(section) ? content_for(section) : default
  end

  def style_for_cell(cell_position)
    style = []
    @maze.sequence.each do |step_in_sequence|
      set_style_from_step(style, step_in_sequence, cell_position)
    end
    @maze.solution.each do |step_in_solution|
      style << 'background: #7AF7A1;' if step_in_solution == cell_position
    end
    style.join
  end

  def set_style_from_step(style, step_in_sequence, cell_position)
    direction = direction_from_step(step_in_sequence.keys)
    position = position_from_step(step_in_sequence.keys)
    style << border_from(direction) if position == cell_position

    direction = direction_from_step(step_in_sequence.values)
    position = position_from_step(step_in_sequence.values)
    style << border_from(direction) if position == cell_position
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
end
