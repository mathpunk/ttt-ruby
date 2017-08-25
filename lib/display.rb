class Display
  def initialize(game)
    game.add_observer(self)
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
    puts "BOARD"
  end
end
