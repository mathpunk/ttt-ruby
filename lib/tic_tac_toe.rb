require "observer"
require "player"
require "display"

class Game
  include Observable

  def initialize
    @moves = Hash.new(:no_one)
    @players = []
    @up = 0
    @display = Display.new(self)
  end
  def start(p1, p2)
    players.push(p1)
    players.push(p2)
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
    if moves[move] == :no_one
      changed
      moves[move] = player
      notify_observers(@moves)
    end
  end
  def review_move(move)
    moves[move]
  end
  def request_move(player)
    player.choose_move(@moves)
  end
  def referee_turn
    player_up = player(:up)
    chosen_move = request_move(player_up)
    accept_move(player_up, chosen_move)
    @up = (@up + 1) % 2   # b/c up and self.up didn't work :(
  end
  def referee_turn_io
    if over?
      end_game
    else
      # @display.update(@moves)
      player_up = player(:up)
      chosen_move = request_move_io(player_up)
      accept_move(player_up, chosen_move)
      @up = (@up + 1) % 2     # why do the other private accessors work, but not this one?
      referee_turn_io
    end
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
  attr_accessor :moves, :players, :up

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

