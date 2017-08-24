require_relative "tic_tac_toe"

game = Game.new
game.start(Player.new, Player.new)
game.referee_turn_io
