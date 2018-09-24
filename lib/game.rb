require_relative 'game_board'
require_relative 'player'

class Game
  attr_reader :player_one, :player_two
  
  def new_player(name)
    @next_mark.nil? ? @next_mark = "\u26ab" : @next_mark = "\u26aa"
    player = Player.new(name, @next_mark)
    @player_one.nil? ? @player_one = player : @player_two = player
  end
end
