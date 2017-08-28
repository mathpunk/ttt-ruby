require "tic_tac_toe"

describe TicTacToe do
  context "when beginning" do
    before(:each) do
      @game = Game.new
      @player = Player.new
      @another_player = Player.new
      @game.start(@player, @another_player)
    end
    it "can get the players" do
      expect(@game.player(1)).to eq(@player)
      expect(@game.player(2)).to eq(@another_player)
    end
    it "is player one's turn to go" do
      expect(@game.player(:up)).to eq(@player)
    end
    it "is player two's turn after a move has been refereed" do
      @game.referee_turn
      expect(@game.player(:up)).to eq(@another_player)
    end
    it "is player one's turn after two moves have been refereed" do
      @game.referee_turn
      @game.referee_turn
      expect(@game.player(:up)).to eq(@player)
    end
  end
  context "when moving" do
    before(:each) do
      @game = Game.new
      @player = Player.new
      @another_player = Player.new
      @move = [1,1]
      @game.accept_move(@player, @move)
    end
    it "remembers who moved to a square" do
      @game.accept_move(@player, @move)
      occupant = @game.review_move(@move)
      expect(occupant).to be(@player)
    end
    it "knows if no one has moved to a square" do
      @game.accept_move(@player, @move)
      no_move = [0,0]
      occupant = @game.review_move(no_move)
      expect(occupant).to be(:no_one)
    end
    it "forbids square-stealing" do
      @game.accept_move(@another_player, @move)
      occupant = @game.review_move(@move)
      expect(occupant).to be(@player)
    end
  end
  context "when playing" do
    before(:each) do
      @game = Game.new
      @player = Player.new
      @another_player = Player.new
      @game.start(@player, @another_player)
    end
    it "begins with player one" do
      expect(@game.player(:up)). to eq(@player)
    end
    it "player two goes next" do
      @game.referee_turn
      expect(@game.player(:up)). to eq(@another_player)
    end
    it "player one goes third" do
      @game.referee_turn
      @game.referee_turn
      expect(@game.player(:up)). to eq(@player)
    end

  end
  context "regarding rows, columns, and diagonals:" do
    before(:each) do
      @game = Game.new
      @player = Player.new
      @another_player = Player.new
    end
    it "rows begin empty" do
      expect(@game.row(0)).to be_empty
      expect(@game.row(1)).to be_empty
      expect(@game.row(2)).to be_empty
    end
    it "rows can be filled" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [0,1])
      @game.accept_move(@player, [0,2])
      expect(@game.row(0).size).to eq(3)
    end
    it "squares in a rows are collinear" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [0,2])
      expect(@game.row(0).size).to be < 3
    end
    it "columns begin empty" do
      expect(@game.column(0)).to be_empty
      expect(@game.column(1)).to be_empty
      expect(@game.column(2)).to be_empty
    end
    it "columns can be filled" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [1,0])
      @game.accept_move(@player, [2,0])
      expect(@game.column(0).size).to eq(3)
    end
    it "squares in a columns are collinear" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [2,0])
      expect(@game.column(0).size).to be < 3
    end
    it "pos_diagonal begins empty" do
      expect(@game.pos_diagonal).to be_empty
      expect(@game.pos_diagonal).to be_empty
      expect(@game.pos_diagonal).to be_empty
    end
    it "pos_diagonal can be filled" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [2,2])
      expect(@game.pos_diagonal.size).to eq(3)
    end
    it "squares in the pos_diagonal are collinear" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [1,2])
      @game.accept_move(@player, [2,2])
      expect(@game.pos_diagonal.size).to be < 3
    end
    it "neg_diagonal begins empty" do
      expect(@game.neg_diagonal).to be_empty
      expect(@game.neg_diagonal).to be_empty
      expect(@game.neg_diagonal).to be_empty
    end
    it "neg_diagonal can be filled" do
      @game.accept_move(@player, [0,2])
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [2,0])
      expect(@game.neg_diagonal.size).to eq(3)
    end
    it "squares in the neg_diagonal are collinear" do
      @game.accept_move(@player, [0,2])
      @game.accept_move(@player, [1,2])
      @game.accept_move(@player, [2,0])
      expect(@game.neg_diagonal.size).to be < 3
    end
  end
  context "when victory conditions met" do
    before(:each) do
      @game = Game.new
      @player = Player.new
      @another_player = Player.new
    end
    it "can award victory to player one" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [2,2])
      expect(@game.winner).to eq(@player)
    end
    it "can award victory to player two" do
      @game.accept_move(@another_player, [0,0])
      @game.accept_move(@another_player, [1,0])
      @game.accept_move(@another_player, [2,0])
      expect(@game.winner).to eq(@another_player)
    end
    it "can award victory to player one in another way" do
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [1,0])
      @game.accept_move(@player, [1,2])
      expect(@game.winner).to eq(@player)
    end
    it "is over" do
      @game.accept_move(@player, [0,0])
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [2,2])
      expect(@game.over?).to be true
    end
  end
  context "in a cat's game" do
    before(:each) do
      @game = Game.new
      @player = Player.new
      @another_player = Player.new
      @game.accept_move(@player, [0,1])
      @game.accept_move(@player, [1,1])
      @game.accept_move(@player, [1,2])
      @game.accept_move(@player, [2,0])
      @game.accept_move(@player, [2,2])

      @game.accept_move(@another_player, [0,0])
      @game.accept_move(@another_player, [0,2])
      @game.accept_move(@another_player, [1,0])
      @game.accept_move(@another_player, [2,1])
    end
    it "does not award victory to anyone" do
      expect(@game.winner).to eq(:no_one)
    end
    it "is over" do
      expect(@game.over?).to be true
    end
  end
end

describe Display do
  before(:each) do
    @game = Game.new
    @display = Display.new(@game)
  end
  it "builds marked rows (col 0)" do
    row = @display.mark_row(0, "X")
    expected = " X |   |   "
    expect(row).to eq(expected)
  end
  it "builds marked rows (col 1)" do
    row = @display.mark_row(1, "O")
    expected = "   | O |   "
    expect(row).to eq(expected)
  end
  it "builds marked rows (col 2)" do
    row = @display.mark_row(2, "#")
    expected = "   |   | # "
    expect(row).to eq(expected)
  end
end
