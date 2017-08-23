require "game"
require "board"
require "move"
require "referee"

describe Board do
  context "when empty" do
    before(:each) do
      @board = Board.empty
    end
    it "is empty" do
      expect(@board.empty?).to be true
    end
    it "isn't empty after a move" do
      move = Move.new("Tom", [1,1])
      @board.move(move)
      expect(@board.empty?).to be_falsey
    end
    it "can retrieve a move that's just been made" do
      move_made = Move.new("Tom", [1,1])
      @board.move(move_made)
      move_retrieved = @board.getByLocation(move_made.where)
      expect(move_retrieved).to eq(move_made)
    end
  end
end
