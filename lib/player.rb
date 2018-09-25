class Player
  attr_reader :name, :mark
  def initialize(name, color)
    @name = name
    @mark = pick_color(color)
  end

  def pick_color(color)
    case color
    when 'red'
      "\e[31m\u26ab\e[0m"
    when 'yellow'
      "\e[33m\u26ab\e[0m"
    end
  end
end
