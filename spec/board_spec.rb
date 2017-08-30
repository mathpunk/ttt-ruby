require "player"
require "tic_tac_toe"
require "board"
require "move"

describe Board do
  context "rows, columns, and diagonals" do
    before(:each) do
      @player = DeterministicPlayer.new(1)
      @another_player = DeterministicPlayer.new(2)
      @game = Game.new(@player, @another_player)
      @board = @game.board
    end
    context "emptiness" do
      it "rows begin empty" do
        expect(@board.row(0)).to be_empty
        expect(@board.row(1)).to be_empty
        expect(@board.row(2)).to be_empty
      end
      it "columns begin empty" do
        expect(@board.column(0)).to be_empty
        expect(@board.column(1)).to be_empty
        expect(@board.column(2)).to be_empty
      end
      it "pos_diagonal begins empty" do
        expect(@board.pos_diagonal).to be_empty
        expect(@board.pos_diagonal).to be_empty
        expect(@board.pos_diagonal).to be_empty
      end
      it "neg_diagonal begins empty" do
        expect(@board.neg_diagonal).to be_empty
        expect(@board.neg_diagonal).to be_empty
        expect(@board.neg_diagonal).to be_empty
      end
    end
  end
end
