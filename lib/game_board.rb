class GameBoard
  attr_reader :grid

  def initialize
    @grid = Array.new(7) { [] }
  end

  def show
    row = 5
    until row < 0
      @grid.each do |cell|
        cell[row].nil? ? print(" \u26aa") : print(" #{cell[row]}")
      end
      puts
      row -= 1
    end
  end

  def put_piece(piece, column)
    @grid[column - 1] << piece
  end
end
