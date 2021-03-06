require "minimax_player"
require "interface"
require "io"

describe MinimaxPlayer do

  context "game value" do
    it "is 1 for a P1 win" do
      interface = Interface.new(:test_win_player1, @io)
      interface.start_game
      game = interface.game
      expect(Minimax.game_value(game)).to eq 1
    end

    it "is -1 for a P2 win" do
      interface = Interface.new(:test_win_player2, @io)
      interface.start_game
      game = interface.game
      expect(Minimax.game_value(game)).to eq(-1)
    end

    it "is 0 for a draw" do
      interface = Interface.new(:test_draw, @io)
      interface.start_game
      game = interface.game
      expect(Minimax.game_value(game)).to eq(0)
    end
  end

  context "move/spot value" do
    context "when both players have two in a row" do
      before(:each) do
        player1 = DeterministicPlayer.new([1, 5, 8])
        player2 = DeterministicPlayer.new([3, 6])
        @max_player = MinimaxPlayer.new(:maximize)
        @min_player = MinimaxPlayer.new(:minimize)
        @game = Game.new(player1: player1, player2: player2)
      end

      context "and it's P1's turn to act" do
        it "is 1 for the winning move" do
          4.times { |_| @game.run_ply }
          expect(@max_player.spot_value(@game, 9)).to eq 1
        end

        it "is -1 for a blunder" do
          4.times { |_| @game.run_ply }
          expect(@max_player.spot_value(@game, 8)).to eq(-1)
        end
      end

      context "and it's P2's turn to act" do
        it "is -1 for the winning move" do
          5.times { |_| @game.run_ply }
          expect(@min_player.spot_value(@game, 9)).to eq(-1)
        end

        it "is 1 for a blunder" do
          5.times { |_| @game.run_ply }
          expect(@min_player.spot_value(@game, 8)).to eq(1)
        end
      end

    end

    context "for a cat's game" do
      before(:each) do
        player1 = DeterministicPlayer.new([1, 2, 7, 6])
        player2 = DeterministicPlayer.new([5, 3, 4, 8])
        @game = Game.new(player1: player1, player2: player2)
        @min_player = MinimaxPlayer.new(:minimize)
        @max_player = MinimaxPlayer.new(:maximize)
      end

      context "when it's P2's turn to act" do
        it "is 0" do
          7.times { |_| @game.run_ply }
          expect(@min_player.spot_value(@game, 8)).to eq 0
          expect(@min_player.spot_value(@game, 9)).to eq 0
        end
      end

      context "when it's P1's turn to act" do
        it "is 0" do
          8.times { |_| @game.run_ply }
          expect(@max_player.spot_value(@game, 9)).to eq 0
        end
      end

    end

    context "best_response" do

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
          it "the best move is to play to win" do
            4.times { |_| @game.run_ply }
            expect(@max_player.best_response(@game)).to eq @winning_move.spot
          end
        end

        context "and it's P2's turn to act" do
          it "the best move is to play to win" do
            5.times { |_| @game.run_ply }
            expect(@min_player.best_response(@game)).to eq @winning_move.spot
          end
        end
      end

      context "in a cat's game" do
        before(:each) do
          player1 = DeterministicPlayer.new([1, 2, 7, 6])
          player2 = DeterministicPlayer.new([5, 3, 4, 8])
          @game = Game.new(player1: player1, player2: player2)
          @min_player = MinimaxPlayer.new(:minimize)
          @max_player = MinimaxPlayer.new(:maximize)
        end

        context "when it's P2's turn to act" do
          it "accepts a tie" do
            7.times { |_| @game.run_ply }
            expect(@min_player.best_response(@game)).to eq(8).or eq(9)
          end
        end

        context "when it's P1's turn to act" do
          it "accepts a tie" do
            8.times { |_| @game.run_ply }
            expect(@max_player.best_response(@game)).to eq(8).or eq(9)
          end
        end

      end

    end

  end
end
