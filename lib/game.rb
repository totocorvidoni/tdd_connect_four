require_relative 'game_board'
require_relative 'player'

class Game
  attr_reader :player_one, :player_two, :board

  def initialize
    @board = GameBoard.new
  end

  def new_player(name)
    if @player_one.nil?
      @player_one = Player.new(name, 'red')
    else
      @player_two = Player.new(name, 'yellow')
    end
  end
end
