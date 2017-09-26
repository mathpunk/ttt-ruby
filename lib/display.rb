class Display

  BLANK_CELL = "   "
  HORIZONTAL_DIVIDER = "\n---+---+---\n"

  def to_s(board)
    dividers = ["|", "|", HORIZONTAL_DIVIDER, "|", "|", HORIZONTAL_DIVIDER, "|", "|", "\n\n"]
    squares(board).zip(dividers).concat.flatten.join("")
  end

  private
  attr_reader :board

  def marked_cell(mark)
    " " + mark + " "
  end

  def squares(board)
    board.moves.map do |occupant|
      if occupant == :no_one
        BLANK_CELL
      else
        marked_cell(occupant.mark)
      end
    end
  end
end
