require_relative "display"

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
end
