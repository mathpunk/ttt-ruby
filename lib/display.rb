class Display
  attr_reader :view
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

  def board_cells(board)
    sprites = []
    (1..9).each do |spot|
      occupant = board.review_move(Move.new(spot))
      if occupant == :no_one
        sprites.push(blank_cell)
      else
        sprites.push(marked_cell("X"))
      end
    end
    sprites
  end
  def draw_board(moves)
    cells = board_cells(moves)
    dividers = ["|", "|", horizontal_divider, "|", "|", horizontal_divider, "|", "|"]
    cells.zip(dividers).concat.flatten.join("")
  end
  def update
    puts @board
  end
end
