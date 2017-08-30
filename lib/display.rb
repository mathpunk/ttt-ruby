class Display
  def initialize(game, board)
    @game = game
    @board = board
    @game.add_observer(self)
    @board.add_observer(self)
  end
  def blank_cell
    "   "
  end
  def marked_cell(mark)
    " " + mark + " "
  end
  def empty_row
    "   |   |   \n"
  end
  def horizontal_divider
    "\n---+---+---\n"
  end
  def squares
    sprites = []
    board.moves.each do |occupant|
      if occupant == :no_one
        sprites.push(blank_cell)
      else
        sprites.push(marked_cell(occupant.mark))
      end
    end
    sprites
  end
  def board_representation
    dividers = ["|", "|", horizontal_divider, "|", "|", horizontal_divider, "|", "|"]
    squares.zip(dividers).concat.flatten.join("")
  end
  def update
    puts board_representation
  end
  private
  attr_reader :board
end
