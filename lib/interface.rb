require_relative "game"
require_relative "player"

class Interface
  def initialize(mode, io)
    case mode
    when :interactive
      @io = io
      gather_players
    when :test_win
      @player1 = DeterministicPlayer.new("Deterministic P1", "X", [1, 9, 4, 7])
      @player2 = DeterministicPlayer.new("Deterministic P2", "O", [5, 2, 3])
      @io = io
    when :test_draw
      @player1 = DeterministicPlayer.new("Deterministic P1", "X",[1, 2, 7, 6, 9])
      @player2 = DeterministicPlayer.new("Deterministic P2", "O", [5, 3, 4, 8])
      @io = io
    end
  end

  def gather_players
    player1_message = "Enter name of player 1, or leave blank for a computer player: "
    io.say(player1_message)
    player1_name = io.ask
    if player1_name.empty?
      @player1 = RandomPlayer.new("Computer", "X")
    else
      @player1 = ConsolePlayer.new(player1_name, "X")
    end
    player2_message = "Enter name of player 2, or leave blank for a computer player: "
    io.say(player2_message)
    player2_name = io.ask
    if player2_name.empty?
      @player2 = RandomPlayer.new("Computer", "O")
    else
      @player2 = ConsolePlayer.new(player2_name, "O")
    end
  end

  def run_game
    start_game
    announce_winner
    play_again_shall_we
  end

  def start_game
    @game = Game.new(player1: @player1, player2: @player2)
    game.play
  end

  def announce_winner
    winner = game.winner
    if winner == :no_one
      io.say "It's a draw!"
    else
      io.say "#{game.winner.name} wins!"
    end
  end

  def play_again_shall_we
    io.say "Play again? (y/n)"
    response = io.ask
    case response
    when "y"
      run_game
    when "Y"
      run_game
    else
      io.say "Thanks for playing!"
    end
  end

  def player(question)
    case question
    when 1
      @player1
    when 2
      @player2
    end
  end


  private
  attr_reader :io, :game

end
