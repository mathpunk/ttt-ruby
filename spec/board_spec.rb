require "player"
require "board"
require "game"

describe Board do

  context "rows, columns, and diagonals" do
    before(:each) do
      @player = DeterministicPlayer.new("Player1", "X", [])
      @another_player = DeterministicPlayer.new("Player2", "O", [])
      @game = Game.new(player1: @player, player2: @another_player)
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

    context "as a data structure for moves" do
      before(:each) do
        @player = DeterministicPlayer.new("Player 1", "X", [1])
        @another_player = DeterministicPlayer.new("Player 2", "O", [2])
        @player_first_move = @player.peek
        @game = Game.new(player1: @player, player2: @another_player)
        @board = @game.board
        @game.run_ply
      end
      it "remembers who moved to a square" do
        expect(@board.review_move(@player_first_move)).to eq(@player)
      end
      it "remembers unoccupied squares" do
        didnt_move = @another_player.peek
        occupant = @board.review_move(didnt_move)
        expect(occupant).to be(:no_one)
      end
    end
  end
end
