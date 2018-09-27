require_relative 'game'
require_relative 'game_board'
require_relative 'player'
game = Game.new
rules = "A two-player connection game in which the players first choose a color and then take turns dropping one colored disc from the top into a seven-column, six-row vertically suspended grid. The pieces fall straight down, occupying the lowest available space within the column. The objective of the game is to be the first to form a horizontal, vertical, or diagonal line of four of one's own discs."

puts 'WELCOME TO CONNECT FOUR'
puts
puts rules.center(4)
puts
puts 'Let\'s begging, shall we?'
puts 'Player 1, please state your name'
name = gets.chomp
game.new_player(name)
puts "Pleased to meet you #{game.player_one.name}. Your marker will be #{game.player_one.mark}"
puts 'Now, who will be Player 2?'
puts
puts 'Hello there! Would you mind telling us your name?'
name = gets.chomp
game.new_player(name)
puts "Pleased to meet you #{game.player_two.name}. You have been chosen as Player 2 \n
and your marker will be #{game.player_two.mark}"
puts
puts 'Now, it\'s everybody ready?'
puts 'CONNECT FOUR STARTS...NOW'
puts
game.start_game
