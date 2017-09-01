require_relative "game"
require_relative "player"

game = Game.new(player1: ConsolePlayer.new("A. Human", "X"),
                player2: Player.new("Rando Calrissian", "O"))
game.play
