require "game"
require "player"

class MC
  def self.openingCeremony
    puts "The MC says: \"Let's play Tic...! Tac...! TOOOOOOOOOOEEE\""
    game = Game.new
    computer_player = Player.new("Hal")
    human_player = Player.new("Tom")
    game.admitPlayer(computer_player)
    game.admitPlayer(human_player)
    game
  end
end
