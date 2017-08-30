require "game"
require "move"
require "player"

describe Game do
  context "when beginning" do
    before(:each) do
      @player = Player.new
      @another_player = Player.new
      @game = Game.new(@player, @another_player)
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
      @player = Player.new
      @another_player = Player.new
      @game = Game.new(@player, @another_player)
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
      @player = DeterministicPlayer.new(1)
      @same_player = DeterministicPlayer.new(1)
      @game = Game.new(@player, @same_player)
      @game.play_round
    end
    it "tells the player square-stealing is forbidden" do
      expect{@game.play_round}.to output(/That square is occupied. Choose another./).to_stdout
    end
    # Q: How to say, expect @same_player to receive choose_move twice?
  end
  context "when a game is played" do
    before(:each) do
      @player = DeterministicPlayer.new(1)
      @another_player = DeterministicPlayer.new(2)
      @game = Game.new(@player, @another_player)
      @game.play
    end
    it "ends" do
      expect(@game.over?).to be true
    end
    it "recognizes DeterministicPlayer(1) as the winner" do
      expect(@game.winner).to be(@player)
    end
  end
  # context "in a cat's game" do
  #   before(:each) do

  #     @player = Player.new
  #     @another_player = Player.new
  #     @game = Game.new(@player, @another_player)
  #     # @game.accept_move(@player, Move.new([0,1]))
  #     # @game.accept_move(@player, Move.new([1,1]))
  #     # @game.accept_move(@player, Move.new([1,2]))
  #     # @game.accept_move(@player, Move.new([2,0]))
  #     # @game.accept_move(@player, Move.new([2,2]))

  #     # @game.accept_move(@another_player, Move.new([0,0]))
  #     # @game.accept_move(@another_player, Move.new([0,2]))
  #     # @game.accept_move(@another_player, Move.new([1,0]))
  #     # @game.accept_move(@another_player, Move.new([2,1]))
  #   end
  #   it "does not award victory to anyone" do
  #     expect(@game.winner).to eq(:no_one)
  #   end
  #   it "is over" do
  #     expect(@game.over?).to be true
  #   end
  # end
end
