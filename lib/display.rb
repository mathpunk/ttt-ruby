class Display
  # def self.display_observing(board:)
  #   display = new(board)
  #   board.add_observer(display)
  #   display
  # end

  BLANK_CELL = "   "
  HORIZONTAL_DIVIDER = "\n---+---+---\n"

  def initialize(game, board)
    @board = board
    game.add_observer(self)
    @board.add_observer(self)
  end

  def to_s
    board_representation
  end

  def update
    puts to_s
  end

  private
  attr_reader :board

  def marked_cell(mark)
    " " + mark + " "
  end

  def squares
    board.moves.map do |occupant|
      if occupant == :no_one
        BLANK_CELL
      else
        marked_cell(occupant.mark)
      end
    end
  end

  def board_representation
    dividers = ["|", "|", HORIZONTAL_DIVIDER, "|", "|", HORIZONTAL_DIVIDER, "|", "|", "\n\n"]
    squares.zip(dividers).concat.flatten.join("")
  end

end
