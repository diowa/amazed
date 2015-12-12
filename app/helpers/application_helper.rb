module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def yield_or_default(section, default = '')
    content_for?(section) ? content_for(section) : default
  end

  def style_for_cell(cell_position)
    style = []
    @maze.carving_steps.each do |step|
      style << "border-#{border_from(step[2])}: 0;" if [step[0], step[1]] == cell_position
    end
    @maze.solution_steps.each do |step|
      style << 'background: #7AF7A1;' if step == cell_position
    end
    style.join
  end

  def border_from(direction)
    case direction
    when :U then 'top'
    when :D then 'bottom'
    when :L then 'left'
    when :R then 'right'
    end
  end
end
