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

    context "P1 to win" do
      before(:each) do
        @player1 = DeterministicPlayer.new("P1", "X", [1, 2])
        @player2 = DeterministicPlayer.new("P2", "O", [4, 5])
        @winning_move = Move.new(3)
        @game = Game.new(player1: @player1, player2: @player2)
        4.times { |_| @game.play_round }
      end

      it "computes the value of a move that wins for P1" do
        value = Minimax.move_value(@game, @player1, @winning_move)
        expect(value).to eq 1
      end

      it "finds a move that will win for P1" do
        maxima = Minimax.maxima(@game, @player1)
        expect(maxima.any? { |move| move.spot == @winning_move.spot }).to be_truthy
      end

      it "ignores non-winning moves" do
        maxima = Minimax.maxima(@game, @player1)
        expect(maxima.size).to eq 1
      end

    end
  end

  context "minimizing" do

    context "P2 to win" do
      before(:each) do
        @player1 = DeterministicPlayer.new("P1", "X", [1, 2, 9])
        @player2 = DeterministicPlayer.new("P2", "O", [4, 5])
        @game = Game.new(player1: @player1, player2: @player2)
        @winning_move = Move.new(6)
        4.times { |_| @game.play_round }
      end

      it "computes the value of a move that wins for P2" do
        value = Minimax.move_value(@game, @player2, @winning_move)
        expect(value).to eq -1
      end

      it "finds a move that will win for P2" do
        maxima = Minimax.minima(@game, @player2)
        expect(maxima.any? { |move| move.spot == @winning_move.spot }).to be_truthy
      end

      it "ignores non-winning moves" do
        maxima = Minimax.minima(@game, @player2)
        expect(maxima.size).to eq 1
      end

    end
  end
end
