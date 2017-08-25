class Display
  def initialize # (game)
    # game.add_observer(self)
    @dummy_counter = 0
  end
  def empty_row
    "   |   |   "
  end
  def divider
    "---+---+---"
  end
  def empty_board
    empty_row + divider + empty_row + divider + empty_row
  end
  def mark_row(column, mark)
    index = { 0 => 1, 1 => 5, 2 => 9}[column]
    chars = empty_row.chars
    chars[index] = mark
    chars.join("")
  end
  def update
    @dummy_counter = @dummy_counter + 1
    puts @dummy_counter
  end
end
