require_relative "lib/tic_tac_toe"

game = Game.new
game.start(Player.new, Player.new)
game.referee_turn_io
