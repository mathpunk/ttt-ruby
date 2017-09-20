require "minimax_player"
require "interface"
require "io"

describe MinimaxPlayer do
  before(:each) do
    @minimax_player = MinimaxPlayer.new(:maximizing)
    @other_player = RandomPlayer.new
  end

  context "available moves" do
    it "have count nine in a new game" do
      game = Game.new(player1: @minimax_player, player2: @other_player)
      expect(@minimax_player.available_spots(game).size).to eq 9
    end

    it "have count eight after one ply" do
      game = Game.new(player1: @other_player, player2: @minimax_player)
      game.run_ply
      expect(@minimax_player.available_spots(game).size).to eq 8
    end
  end

  context "game value" do
    it "is 1 for a P1 win" do
      interface = Interface.new(:test_win_player1, @io)
      interface.start_game
      game = interface.game
      expect(@minimax_player.game_value(game)).to eq 1
    end

    it "is -1 for a P2 win" do
      interface = Interface.new(:test_win_player2, @io)
      interface.start_game
      game = interface.game
      expect(@minimax_player.game_value(game)).to eq(-1)
    end

    it "is 0 for a draw" do
      interface = Interface.new(:test_draw, @io)
      interface.start_game
      game = interface.game
      expect(@minimax_player.game_value(game)).to eq(0)
    end
  end

  context "move/spot value" do
    context "when both players have two in a row" do

      context "and it's P1's turn to act" do
        before(:each) do
          player1 = DeterministicPlayer.new([1, 5])
          player2 = DeterministicPlayer.new([3, 6])
          @game = Game.new(player1: player1, player2: player2)
        end

        it "is 1 for the winning move" do
          4.times { |_| @game.run_ply }
          expect(@minimax_player.spot_value(@game, 9)).to eq 1
        end

        xit "is -1 for a blunder" do
          4.times { |_| @game.run_ply }
          expect(@minimax_player.spot_value(@game, 8)).to eq(-1)
        end
      end

      context "and it's P2's turn to act" do
        before(:each) do
          player1 = DeterministicPlayer.new([1, 5, 8])
          player2 = DeterministicPlayer.new([3, 6])
          @game = Game.new(player1: player1, player2: player2)
        end

        it "is -1 for the winning move" do
          5.times { |_| @game.run_ply }
          expect(@minimax_player.spot_value(@game, 9)).to eq(-1)
        end

        it "is 1 for a blunder" do
          4.times { |_| @game.run_ply }
          expect(@minimax_player.spot_value(@game, 8)).to eq(1)
        end
      end

    end

    context "for a cat's game" do
      before(:each) do
        player1 = DeterministicPlayer.new([1, 2, 6, 7, 9])
        player2 = DeterministicPlayer.new([5, 3, 4, 8])
        @game = Game.new(player1: player1, player2: player2)
      end

      context "when it's P1's turn to act" do
        it "is 0" do
          6.times { |_| @game.run_ply }
          expect(@minimax_player.spot_value(@game, 7)).to eq 0
          expect(@minimax_player.spot_value(@game, 8)).to eq 0
          expect(@minimax_player.spot_value(@game, 9)).to eq 0
        end
      end

      context "when it's P2's turn to act" do
        xit "is 0" do
          7.times { |_| @game.run_ply }
          expect(@minimax_player.spot_value(@game, 7)).to eq 0
          expect(@minimax_player.spot_value(@game, 8)).to eq 0
          expect(@minimax_player.spot_value(@game, 9)).to eq 0
        end
      end
    end

    context "smaller response/value functions: " do

      context "when both players have two in a row" do
        before(:each) do
          player1 = DeterministicPlayer.new([1, 5, 8])
          player2 = DeterministicPlayer.new([3, 6])
          @max_player = MinimaxPlayer.new(:maximize)
          @min_player = MinimaxPlayer.new(:minimize)
          @game = Game.new(player1: player1, player2: player2)
          @winning_move = Move.new(9)
        end

        context "and it's P1's turn to act" do
          xit "the best move is to play to win" do
            4.times { |_| @game.run_ply }
            expect(@max_player.best_move(@game).spot).to eq @winning_move.spot
          end
        end

        context "and it's P2's turn to act" do
          xit "the best move is to play to win" do
            5.times { |_| @game.run_ply }
            expect(@min_player.best_move(@game).spot).to eq @winning_move.spot
          end
        end
      end
    end

    context "in a cat's game" do
      before(:each) do
        player1 = DeterministicPlayer.new([1, 2, 6, 7, 9])
        player2 = DeterministicPlayer.new([5, 3, 4, 8])
        @max_player = MinimaxPlayer.new(:maximize)
        @min_player = MinimaxPlayer.new(:minimize)
        @game = Game.new(player1: player1, player2: player2)
      end

      context "when it's P1's turn to act" do
        it "will accept a tie" do
          6.times { |_| @game.run_ply }
          expect(@max_player.best_move(@game).spot).to eq(7).or eq(8).or eq(9)
        end
      end

      context "when it's P2's turn to act" do
        it "will accept a tie" do
          7.times { |_| @game.run_ply }
          expect(@max_player.best_move(@game).spot).to eq(8).or eq(9)
        end
      end

    end
  end
end
