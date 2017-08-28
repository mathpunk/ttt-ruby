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
