require "minimax"
require "interface"
require "io"

describe Minimax do
  before(:each) do
    @io = MockIO.new
  end

  context "end game" do

    it "computes value of 1 for a game with a P1 win" do
      interface = Interface.new(:test_win_player1, @io)
      interface.start_game
      game = interface.game
      expect(Minimax.value(game)).to eq 1
    end

    it "computes value of -1 for a game with a P2 win" do
      interface = Interface.new(:test_win_player2, @io)
      interface.start_game
      game = interface.game
      expect(Minimax.value(game)).to eq -1
    end

    it "computes value of 0 for a game ending in a draw" do
      interface = Interface.new(:test_draw, @io)
      interface.start_game
      game = interface.game
      expect(Minimax.value(game)).to eq 0
    end
  end

  context "maximizing" do
    it "finds the value of a move that wins for P1" do
      player1 = DeterministicPlayer.new("P1", "X", [1, 2])
      player2 = DeterministicPlayer.new("P2", "O", [4, 5])
      game = Game.new(player1: player1, player2: player2)
      game.play_round
      game.play_round
      game.play_round
      game.play_round
      value = Minimax.move_value(game, player1, Move.new(3))
      expect(value).to eq 1
    end
    it "finds a move that will win for P1" do
      player1 = DeterministicPlayer.new("P1", "X", [1, 2])
      player2 = DeterministicPlayer.new("P2", "O", [4, 5])
      game = Game.new(player1: player1, player2: player2)
      game.play_round
      game.play_round
      game.play_round
      game.play_round
      maxima = Minimax.maxima(game, player1)
      expect(maxima.any? {|pair| pair[0].spot == 3}).to be_truthy
    end
  end

end
