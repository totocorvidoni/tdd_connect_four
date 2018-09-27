class GameBoard
  attr_accessor :grid

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
    puts " \e[32m\u24f5\e[0m \e[32m\u24f6\e[0m \e[32m\u24f7\e[0m \e[32m\u24f8\e[0m \e[32m\u24f9\e[0m \e[32m\u24fa\e[0m \e[32m\u24fb\e[0m"
  end

  def put_piece(piece, x_axis)
      @grid[x_axis] << piece
  end
end
