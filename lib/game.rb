require "board"

class Game
  def initialize(p1, p2)
    @players = [p1, p2]
    @board = Board.new
  end
  def play
    true
  end
  def over?
    true
  end
  def result
    "draw"
  end
  def players
    @players
  end
  def board
    @board
  end
end
