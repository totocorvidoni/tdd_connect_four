class GameBoard
  attr_reader :cells

  def initialize
    set_up
  end

  def set_up
    @cells = []
    6.times { @cells << [' ', ' ', ' ', ' ', ' ', ' ', ' '] }
  end
end
