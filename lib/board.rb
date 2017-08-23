require "observer"

class Board
  include Observable
  attr_reader :moves

  def initialize(moves)
    @moves = moves
  end

  def self.empty
    Board.new(Hash.new)
  end

  def empty?
    moves.empty?
  end

  def move(a_move)
    moves[a_move.where] = a_move
    changed
    notify_observers(self)
  end

  def full?
    moves.size == 9
  end

  def getByLocation(location)
    moves[location]
  end
end
