require "player"
require "tic_tac_toe"
require "board"
require "move"

describe Board do
  context "regarding rows, columns, and diagonals:" do
    before(:each) do
      @player = Player.new
      @another_player = Player.new
      @game = Game.new(@player, @another_player)
      @board = @game.board
    end
    it "rows begin empty" do
      expect(@board.row(0)).to be_empty
      expect(@board.row(1)).to be_empty
      expect(@board.row(2)).to be_empty
    end
    it "rows can be filled" do
      @game.accept_move(@player, Move.new([0,0]))
      @game.accept_move(@player, Move.new([0,1]))
      @game.accept_move(@player, Move.new([0,2]))
      expect(@board.row(0).size).to eq(3)
    end
    it "squares in a rows are collinear" do
      @game.accept_move(@player, Move.new([0,0]))
      @game.accept_move(@player, Move.new([1,1]))
      @game.accept_move(@player, Move.new([0,2]))
      expect(@board.row(0).size).to be < 3
    end
    it "columns begin empty" do
      expect(@board.column(0)).to be_empty
      expect(@board.column(1)).to be_empty
      expect(@board.column(2)).to be_empty
    end
    it "columns can be filled" do
      @game.accept_move(@player, Move.new([0,0]))
      @game.accept_move(@player, Move.new([1,0]))
      @game.accept_move(@player, Move.new([2,0]))
      expect(@board.column(0).size).to eq(3)
    end
    it "squares in a columns are collinear" do
      @game.accept_move(@player, Move.new([0,0]))
      @game.accept_move(@player, Move.new([1,1]))
      @game.accept_move(@player, Move.new([2,0]))
      expect(@board.column(0).size).to be < 3
    end
    it "pos_diagonal begins empty" do
      expect(@board.pos_diagonal).to be_empty
      expect(@board.pos_diagonal).to be_empty
      expect(@board.pos_diagonal).to be_empty
    end
    it "pos_diagonal can be filled" do
      @game.accept_move(@player, Move.new([0,0]))
      @game.accept_move(@player, Move.new([1,1]))
      @game.accept_move(@player, Move.new([2,2]))
      expect(@board.pos_diagonal.size).to eq(3)
    end
    it "squares in the pos_diagonal are collinear" do
      @game.accept_move(@player, Move.new([0,0]))
      @game.accept_move(@player, Move.new([1,2]))
      @game.accept_move(@player, Move.new([2,2]))
      expect(@board.pos_diagonal.size).to be < 3
    end
    it "neg_diagonal begins empty" do
      expect(@board.neg_diagonal).to be_empty
      expect(@board.neg_diagonal).to be_empty
      expect(@board.neg_diagonal).to be_empty
    end
    it "neg_diagonal can be filled" do
      @game.accept_move(@player, Move.new([0,2]))
      @game.accept_move(@player, Move.new([1,1]))
      @game.accept_move(@player, Move.new([2,0]))
      expect(@board.neg_diagonal.size).to eq(3)
    end
    it "squares in the neg_diagonal are collinear" do
      @game.accept_move(@player, Move.new([0,2]))
      @game.accept_move(@player, Move.new([1,2]))
      @game.accept_move(@player, Move.new([2,0]))
      expect(@board.neg_diagonal.size).to be < 3
    end
  end

end
