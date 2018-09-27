require_relative 'game_board'
require_relative 'player'

class Game
  attr_reader :player_one, :player_two, :board, :playing

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

  def start_game
    until @game_over
      @board.show
      col = gets.to_i
      move(col)
      end_check
      switch_player
    end
    @board.show
  end

  def move(column)
    x_axis = column - 1
    begin
      raise ArgumentError.new unless (0..6) === x_axis && @board.grid[x_axis].size < 6
      @board.put_piece(@playing.mark, x_axis)
      @moving = x_axis
    rescue ArgumentError
      puts 'Invalid Move'
      puts 'Please pick a correct column'
      amend = gets.to_i
      move(amend)
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
    x_axis = @moving - 3
    y_axis = @board.grid[@moving].rindex(@playing.mark) + 3
    diagonal_1 = []
    7.times do
      if @board.grid[x_axis].nil? || y_axis < 0
        diagonal_1 << nil
      else
        diagonal_1 << @board.grid[x_axis].fetch(y_axis, nil)
      end
      x_axis, y_axis = x_axis + 1, y_axis - 1
    end
    x_axis = @moving - 3
    y_axis = @board.grid[@moving].rindex(@playing.mark) - 3
    diagonal_2 = []
    7.times do
      if @board.grid[x_axis].nil? || y_axis < 0
        diagonal_2 << nil
      else
        diagonal_2 << @board.grid[x_axis].fetch(y_axis, nil)
      end
      x_axis, y_axis = x_axis + 1, y_axis + 1
    end
    binding.pry
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

  def end_check
    if @board.grid.map { |x| x.size }.all?(6)
      end_game('tie')
    elsif column_win? || row_win? || diagonal_win?
      end_game(@playing.name)
    end
  end

  def end_game(reason)
    if reason == 'tie'
      puts "The board is full, it's a TIE"
    elsif reason == @playing.name
      puts "#{reason} connected four! #{reason} WINS THE GAME"
    end
    puts
    @game_over = true
  end
end
