require "game"

class Ceremony
  def initialize(io)
    @io = io
  end

  def begin
    message = "Are you ready for some Tic... Tac... Toooooe!!?!!?!!?"
    io.say(message)
  end

  def start_game
    player1 = Player.new
    player2 = Player.new
    game = Game.new(player1: player1, player2: player2)
    message = "Let's begin!"
    io.say(message)
    game.play
  end

  # def conduct
  #   self.begin
  #   start_game
  # end

  private
  attr_reader :io
end
