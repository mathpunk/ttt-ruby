require_relative "tic_tac_toe"
require_relative "player"

game = Game.new(Player.new, Player.new)
game.play
