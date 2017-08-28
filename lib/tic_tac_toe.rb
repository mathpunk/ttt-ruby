require "observer"
require "player"
require "display"

class Board
  include Observable
  attr_reader :moves
  def initialize
    @moves = Hash.new(:no_one)
    @display = Display.new(self)
  end
  def accept_move(player, move)
    if moves[move] == :no_one
      changed
      moves[move] = player
      notify_observers(moves)
    end
  end
  def review_move(move)
    moves[move]
  end
  def row(n)
    moves.select { |move, _| move[0] == n }
  end
  def column(n)
    moves.select { |move, _| move[1] == n }
  end
  def pos_diagonal
    moves.select { |move, _| move[0] == move[1] }
  end
  def neg_diagonal
    moves.select { |move, _| move[0] + move[1] == 2}
  end
end

class Game
  include Observable

  def initialize
    @board = Board.new
    @players = []
    @up = 0
  end
  def start(p1, p2)
    players.push(p1)
    players.push(p2)
  end
  def moves
    @board.moves
  end
  def play
    referee_turn_io
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
    @board.accept_move(player, move)
  end
  def review_move(move)
    @board.review_move(move)
  end
  def request_move(player)
    player.choose_move(moves)
  end
  def referee_turn
    if over?
      end_game
    else
      player_up = player(:up)
      chosen_move = request_move(player_up)
      accept_move(player_up, chosen_move)
      @up = (@up + 1) % 2   # b/c up and self.up didn't work :(
      # referee_turn
    end
  end
  def row(n)
    board.row(n)
  end
  def column(n)
    board.column(n)
  end
  def pos_diagonal
    board.pos_diagonal
  end
  def neg_diagonal
    board.neg_diagonal
  end
  def over?
    winner != :no_one || moves.size == 9
  end
  def winner
    rows = (0..2).reduce([]) { |acc, n| acc.push row(n) }
    columns = (0..2).reduce([]) { |acc, n| acc.push column(n) }
    diagonals = [].push(pos_diagonal).push(neg_diagonal)
    lines = rows + columns + diagonals
    winning_lines = lines.select { |line| winner_of_line(line) }
    winning_line = winning_lines[0] # NB: simultaneous winners unguarded against (but should be impossible)
    winner = winner_of_line(winning_line)
    winner ? winner : :no_one
  end

  def end_game
    puts "Game over"
    puts winner.inspect + " wins"
  end

  private
  attr_accessor :board, :players, :up

  def winner_of_line(line)
    if line.nil? || line.size < 3
      nil
    else
      occupants = line.values
      if occupants.all? { |occupant| occupant == occupants[0] }
        occupants[0]
      else
        nil
      end
    end
  end
end

class TicTacToe
end

