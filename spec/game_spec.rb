require "game"
require "player"

describe Game do

  before(:each) do
    @player = DeterministicPlayer.new("Deterministic P1", "X", [1, 9, 4, 7])
    @same_strategy_player = DeterministicPlayer.new("Deterministic P2", "X", [1, 9, 4, 7])
    @another_player = DeterministicPlayer.new("Deterministic P2", "O", [5, 2, 3])
  end

  context "when beginning" do
    before(:each) do
      @game = Game.new(player1: @player, player2: @another_player)
    end

    it "can get the players" do
      expect(@game.player(1)).to eq(@player)
      expect(@game.player(2)).to eq(@another_player)
    end

  end

  context "turn-taking" do
    before(:each) do
      @game = Game.new(player1: @player, player2: @another_player)
    end

    it "begins with player one" do
      expect(@game.player(:current)). to eq(@player)
    end

    it "player two goes next" do
      @game.run_ply
      expect(@game.player(:current)). to eq(@another_player)
    end

    it "player one goes third" do
      @game.run_ply
      @game.run_ply
      expect(@game.player(:current)). to eq(@player)
    end
  end

  context "valid_move?" do
    it "is false when a player tries to move to an occupied square" do
      @game = Game.new(player1: @player, player2: @same_strategy_player)
      @game.run_ply
      attempted_move = @same_strategy_player.peek
      expect(@game.valid_move?(attempted_move)).to be_falsey
    end
    it "is true when a player tries to move to an unoccupied square" do
      @game = Game.new(player1: @player, player2: @another_player)
      @game.run_ply
      attempted_move = @another_player.peek
      expect(@game.valid_move?(attempted_move)).to be_truthy
    end

    # SHOULD BE INTERFACE RESPONSIBILITY?

  end

  context "when a game is played" do
    before(:each) do
      @game = Game.new(player1: @player, player2: @another_player)
      @game.play
    end

    it "ends" do
      expect(@game.over?).to be true
    end

    it "recognizes DeterministicPlayer(1) as the winner" do
      expect(@game.winner).to be(@player)
    end

  end

  context "in a cat's game" do
    before(:each) do
      @draw_player = DeterministicPlayer.new("Deterministic P1", "X",[1, 2, 7, 6, 9])
      @another_draw_player = DeterministicPlayer.new("Deterministic P2", "O", [5, 3, 4, 8])
      @game = Game.new(player1: @draw_player, player2: @another_draw_player)
      @game.play
    end

    it "does not award victory to anyone" do
      expect(@game.winner).to eq(:no_one)
    end

    it "is over" do
      expect(@game.over?).to be true
    end
  end

  context "when a console player makes an invalid move" do

    context "the unhandled error" do

      it "can be reproduced in the string move case" do
        @qa_player = DeterministicPlayer.new("Q.A. Player", "#", ["q"])
        @player = DeterministicPlayer.new("Player 2", "X", [1, 2, 3, 4, 9])
        game = Game.new(player1: @qa_player, player2: @player)
        expect{game.run_ply}.to raise_error IllFormedMoveError
      end

      it "can be reproduced in the out-of-range int move case" do
        @qa_player = DeterministicPlayer.new("Q.A. Player", "#", [0])
        @player = DeterministicPlayer.new("Player 1", "X", [1, 2, 3, 4, 9])
        game = Game.new(player1: @qa_player, player2: @player)
        expect{game.run_ply}.to raise_error IllFormedMoveError
      end
    end

  end
end
