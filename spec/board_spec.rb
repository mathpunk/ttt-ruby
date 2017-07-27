require "board"

describe Board do

 it "should start out empty" do
    board = Board.new
    expect(board.empty?).to be true
  end

end
