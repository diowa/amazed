module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def yield_or_default(section, default = '')
    content_for?(section) ? content_for(section) : default
  end

  def style_for_cell(cell_position)
    style = []
    @maze.carving_steps.each do |step_in_carving_steps|
      set_style_from_step(style, step_in_carving_steps, cell_position)
    end
    @maze.solution_steps.each do |step_in_solution_steps|
      style << 'background: #7AF7A1;' if step_in_solution_steps == cell_position
    end
    style.join
  end

  def set_style_from_step(style, step_in_carving_steps, cell_position)
    direction = direction_from(step_in_carving_steps.keys)
    position = position_from(step_in_carving_steps.keys)
    style << border_from(direction) if position == cell_position

    direction = direction_from(step_in_carving_steps.values)
    position = position_from(step_in_carving_steps.values)
    style << border_from(direction) if position == cell_position
  end

  def position_from(step_in_carving_steps)
    [step_in_carving_steps.first[0], step_in_carving_steps.first[1]]
  end

  def direction_from(step_in_carving_steps)
    step_in_carving_steps.first[2]
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
