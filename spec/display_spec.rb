require "display"
require "tic_tac_toe"

describe Display do
  before(:each) do
    @game = Game.new
    @display = Display.new(@game)
  end
  it "builds marked rows (col 0)" do
    row = @display.mark_row(0, "X")
    expected = " X |   |   \n"
    expect(row).to include(expected)
  end
  it "builds marked rows (col 1)" do
    row = @display.mark_row(1, "O")
    expected = "   | O |   \n"
    expect(row).to include(expected)
  end
  it "builds marked rows (col 2)" do
    row = @display.mark_row(2, "#")
    expected = "   |   | # \n"
    expect(row).to include(expected)
  end
end
