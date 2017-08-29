require "observer"
require_relative "player"
require_relative "board"

class Game
  attr_reader :board
  # Starting, turn-taking, and ending.
  def initialize(p1, p2)
    @board = Board.new
    @players = [p1, p2]
    @up = 0
  end
  def moves
    board.moves
  end
  def play
    play_round
  end

  def player(question)
    case question
    when 1
      players[0]
    when 2
      players[1]
    when :up
      players[up]
    end
  end
  def accept_move(player, move)
    board.accept_move(player, move)
  end
  def review_move(move)
    board.review_move(move)
  end
  def request_move(player)
    player.choose_move(moves)
  end
  def play_round
    if over?
      end_game
    else
      player_up = player(:up)
      chosen_move = request_move(player_up)
      board.accept_move(player_up, chosen_move)
      @up = (@up + 1) % 2   # b/c up and self.up didn't work :(
      # referee_turn
    end
  end
  def over?
    winner != :no_one || moves.size == 9
  end
  def winner
    @board.winner
  end

  def end_game
    puts "Game over"
    puts winner.inspect + " wins"
  end

  private
  attr_accessor  :players, :up

end

class TicTacToe
end

