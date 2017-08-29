require_relative "display"

class Board
  include Observable
  attr_reader :moves
  def initialize
    @moves = Hash.new(:no_one)
  end
  def accept_move(player, move)
    if moves[move] == :no_one
      changed
      moves[move] = player
      notify_observers(moves)
    else
      :square_occupied
    end
  end
  def review_move(move)
    moves[move]
  end
  def row(n)
    moves.select { |move, _| move.row == n }
  end
  def rows
    (0..2).collect { |n| row(n) }
  end
  def column(n)
    moves.select { |move, _| move.column == n }
  end
  def columns
    (0..2).collect { |n| column(n) }
  end
  def pos_diagonal
    moves.select { |move, _| move.row == move.column }
  end
  def neg_diagonal
    moves.select { |move, _| move.row + move.column == 2}
  end
  def diagonals
    [].push(pos_diagonal).push(neg_diagonal)
  end
  def lines
    rows + columns + diagonals
  end
  def winner
    winner = lines.detect { |line| winner_of_line(line) }
    winner ? winner.values[0] : :no_one
  end
  private
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
