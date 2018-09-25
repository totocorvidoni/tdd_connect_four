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
    begin
      if @grid[column - 1].nil? || @grid[column - 1].size >= 5
        raise ArgumentError.new
      end
      @grid[column - 1] << piece
    rescue ArgumentError
      puts 'Invalid Move'
      puts 'Please pick a correct column'
      col = gets.to_i
      put_piece(piece, col)
    end
  end
end
