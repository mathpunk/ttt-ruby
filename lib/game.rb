require "board"

class Game
  def initialize
    @players = ["Me", "You"]
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
