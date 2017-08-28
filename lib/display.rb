class Display
  attr_reader :view
  def initialize(game)
    game.add_observer(self)
    @view = empty_board
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
  def board_cells(moves)
    cells = []
    (0..2).each do |row_index|
      (0..2).each do |col_index|
        occupant = moves[[row_index, col_index]] 
        if occupant == :no_one
          cells.push(blank_cell)
        else
          cells.push(marked_cell("X"))
        end
      end
    end
    cells
  end
  def draw_board(moves)
    cells = board_cells(moves)
    dividers = ["|", "|", horizontal_divider, "|", "|", horizontal_divider, "|", "|"]
    cells.zip(dividers).concat.flatten.join("")
  end
  def horizontal_divider
    "\n---+---+---\n"
  end
  def empty_board
    draw_board(Hash.new(:no_one))
  end
  def update(moves)
    @view = draw_board(moves)
  end
end
