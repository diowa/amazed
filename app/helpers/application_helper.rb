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
      if step_in_sequence.keys.first[0] == x && step_in_sequence.keys.first[1] == y
        style << border_from(step_in_sequence.keys.first[2])
      end
      if step_in_sequence.values.first[0] == x && step_in_sequence.values.first[1] == y
        style << border_from(step_in_sequence.values.first[2])
      end
    end
    style.join
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
