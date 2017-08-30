require "observer"
require_relative "display"

class Board
  include Observable
  attr_reader :moves

  def initialize
    @moves = Array.new(9, :no_one)
  end

  def accept_move(player, move)
    index = move.spot-1
    if moves[index] == :no_one
      changed
      moves[index] = player
      notify_observers
    else
      :square_occupied # TOO SMART
    end
  end

  def review_move(move)
    index = move.spot-1
    moves[index]
  end

  def row(n)
    moves[3*n,3].reject { |entry| entry == :no_one }
  end

  def rows
    (0..2).collect { |n| row(n) }
  end

  def column(n)
    indices = (0...9).select { |index| index % 3 == n}
    entries = []
    indices.each { |i| entries.push(moves[i]) }
    entries.reject { |entry| entry == :no_one }
  end

  def columns
    (0..2).collect { |n| column(n) }
  end

  def pos_diagonal
    [moves[0], moves[4], moves[8]].reject { |entry| entry == :no_one }
  end

  def neg_diagonal
    [moves[2],moves[4],moves[6]].reject { |entry| entry == :no_one }
  end

  def diagonals
    [].push(pos_diagonal).push(neg_diagonal)
  end

  def lines
    rows + columns + diagonals
  end

  # TOO GAME-Y
end
