require "board"

describe Board do

  before(:each) do
    @board = Board.new
  end

  it "should start out empty" do
    expect(@board.empty?).to be true
  end

  context "when player moves" do
    it "shouldn't be empty" do
      @board.move(:p1, 3)
      expect(@board.empty?).to be false
    end
  end

end
