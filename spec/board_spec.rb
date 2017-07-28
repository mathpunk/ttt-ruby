require "board"
require "player"

describe Board do

  before(:each) do
    @board = Board.new
    @p1 = Player.new(1)
    @p2 = Player.new(2)
  end

  it "should start out empty" do
    expect(@board.empty?).to be true
  end

  context "when player moves" do
    it "shouldn't be empty" do
      @board.move(@p1, 3)
      expect(@board.empty?).to be false
    end
  end

end
