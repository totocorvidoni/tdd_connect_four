class GameBoard
  attr_reader :board
  def set_up
    @board = []
    6.times { @board << [' ', ' ', ' ', ' ', ' ', ' ', ' '] }
  end
end