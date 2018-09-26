require_relative 'game_board'
require_relative 'player'

class Game
  attr_reader :player_one, :player_two, :board, :playing
  attr_writer :moving

  def initialize
    @board = GameBoard.new
  end

  def new_player(name)
    if @player_one.nil?
      @player_one = Player.new(name, 'red')
      @playing = @player_one
    else
      @player_two = Player.new(name, 'yellow')
    end
  end

  def switch_player
    @playing = @playing == @player_one ? @player_two : @player_one
  end

  def move(column)
    @board.put_piece(@playing.mark, column)
    @moving = column - 1
  end

  def end_check
    if @board.grid.map { |x| x.size }.all?(6)
      return 'tie'
    elsif column_win? || row_win? || diagonal_win?
      return @playing
    end
  end

  def column_win?
    return false if @board.grid[@moving].size < 4
    return true if @board.grid[@moving][-4..-1].all?(@playing.mark)
    false
  end

  def row_win?
    row = @board.grid[@moving].rindex(@playing.mark)
    # an array of the horizontal row with empty cells filled with nil
    row_pieces = @board.grid.map { |col| col.fetch(row, nil) }
    return true if connected_4?(row_pieces)
    false
  end

  def diagonal_win?
    x = @moving - 3
    y = @board.grid[@moving].rindex(@playing.mark) + 3
    diagonal_1 = []
    7.times do
      if @board.grid[x].nil?
        diagonal_1 << nil
      else
        diagonal_1 << @board.grid[x].fetch(y, nil)
      end
        x, y = x + 1, y - 1
    end
    x = @moving - 3
    y = @board.grid[@moving].rindex(@playing.mark) - 3
    diagonal_2 = []
    7.times do
      if @board.grid[x].nil?
        diagonal_2 << nil
      else
        diagonal_2 << @board.grid[x].fetch(y, nil) unless @board.grid[x].nil?
      end
        x, y = x + 1, y + 1
    end
    return true if connected_4?(diagonal_1)
    return true if connected_4?(diagonal_2)
    false
  end

  def connected_4?(sample)
    start, stop = 0, 3
    until stop == sample.size
      return true if sample[start..stop].all?(@playing.mark)
      start, stop = start + 1, stop + 1
    end
    false
  end
end
