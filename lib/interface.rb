require_relative "game"
require_relative "player"

class Interface
  def initialize(mode, io)
    case mode
    when :human_computer
      @player1 = ConsolePlayer.new("A. Human", "X")
      @player2 = RandomPlayer.new("Rando Calrissian", "O")
      @io = io
    when :test_win
      @player1 = DeterministicPlayer.new(1)
      @player2 = DeterministicPlayer.new(2)
      @io = io
    when :test_draw
      @player1 = DrawingDeterministicPlayer.new(1)
      @player2 = DrawingDeterministicPlayer.new(2)
      @io = io
    end
  end

  def start_game
    @game = Game.new(player1: @player1, player2: @player2)
    game.play
    winner = game.winner
    if winner == :no_one
      io.say "It's a draw!"
    else
      io.say "#{game.winner.name} wins!"
    end
    io.say "Play again? (y/n)"
    response = io.ask
    case response
    when "y"
      start_game
    when "Y"
      start_game
    else
      io.say "Thanks for playing!"
    end
  end

  private
  attr_reader :io, :game

end
