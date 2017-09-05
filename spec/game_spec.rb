require "game"
require "move"
require "player"

describe Game do

  before(:each) do
    @player = DeterministicPlayer.new(1)
    @same_player = DeterministicPlayer.new(1)
    @another_player = DeterministicPlayer.new(2)
  end

  context "when beginning" do
    before(:each) do
      @game = Game.new(player1: @player, player2: @another_player)
    end

    it "can get the players" do
      expect(@game.player(1)).to eq(@player)
      expect(@game.player(2)).to eq(@another_player)
    end

    it "is player one's turn to go" do
      expect(@game.player(:up)).to eq(@player)
    end
  end

  context "turn-taking" do
    before(:each) do
      @game = Game.new(player1: @player, player2: @another_player)
    end

    it "begins with player one" do
      expect(@game.player(:up)). to eq(@player)
    end

    it "player two goes next" do
      @game.play_round
      expect(@game.player(:up)). to eq(@another_player)
    end

    it "player one goes third" do
      @game.play_round
      @game.play_round
      expect(@game.player(:up)). to eq(@player)
    end
  end

  context "when an occupied square is chosen by a player" do
    before(:each) do
      @game = Game.new(player1: @player, player2: @same_player)
      @game.play_round
    end
    it "tells the player square-stealing is forbidden" do
      expect{@game.play_round}.to output(/That square is occupied. Choose another./).to_stdout
    end
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
      @draw_player = DrawingDeterministicPlayer.new(1)
      @another_draw_player = DrawingDeterministicPlayer.new(2)
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
end
