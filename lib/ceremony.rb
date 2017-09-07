require_relative "game"
require_relative "io"

class Ceremony

  attr_reader :game

  def initialize(io)
    @io = io
    @players = []
    @game = nil
  end

  def start_ceremony
    message = "Are you ready for some Tic... Tac... Toooooe!!?!!?!!?"
    io.say(message)
  end

  def gather_players
  end

  def start_game
    message = "Let's begin!"
    io.say(message)
    @game = Game.new(player1: @players[0], player2: @players[1])
    @game.add_observer(self)
    @game.play
  end

  def update(game)
    if game.over?
      message = "Game over, everyone get out"
      io.say(message)
    end
  end

  # def conduct_play
  #   start_ceremony
  #   gather_players
  #   start_game
  # end

  # def play_again
  #   puts "Play again? (y/n): "
  #   response = gets.chomp
  #   if response == "y" || response == "Y"
  #     game = Game.new(player1: ConsolePlayer.new("A. Human", "X"),
  #       player2: RandomPlayer.new("Rando Calrissian", "O"))
  #     game.play
  #   elsif response == "n" || response == "N"
  #     puts "Thanks for playing!"
  #     nil
  #   else
  #     puts "I didn't understand that. "
  #     play_again
  #   end
  # end


  private
  attr_reader :io

end

class DeterministicCeremony < Ceremony

  def gather_players
    player1 = DeterministicPlayer.new(1)
    player2 = DeterministicPlayer.new(2)
    @players.push(player1)
    @players.push(player2)
    message = "Welcome, #{player1} (X) and #{player2} (O)"
    io.say(message)
  end

end

class DeterministicDrawingCeremony < Ceremony

  def gather_players
    player1 = DrawingDeterministicPlayer.new(1)
    player2 = DrawingDeterministicPlayer.new(2)
    @players.push(player1)
    @players.push(player2)
    message = "Welcome, #{player1} (X) and #{player2} (O)"
    io.say(message)
  end

end
