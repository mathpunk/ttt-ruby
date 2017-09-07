require_relative "ceremony"
require_relative "player"

game = Game.new(player1: ConsolePlayer.new("A. Human", "X"),
                player2: RandomPlayer.new("Rando Calrissian", "O"))
game.play

# ceremony = DeterministicCeremony.new(ConsoleIO)
# ceremony.start_ceremony
