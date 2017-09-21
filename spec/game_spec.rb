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

  context "fixing the invalid move bug" do
    # Observed behavior:

    # Choose a square (1-9):
    # 0
    # 0 is not a valid move.
    # Choose a square (1-9):
    # 9
    # /home/chiral/work/iteration/ttt-ruby/lib/board.rb:21:in `review_move': undefined method `-' for #<Move:0x00557b6f82aa88 @spot=9> (NoMethodError)
    # from /home/chiral/work/iteration/ttt-ruby/lib/game.rb:43:in `valid_move?'
    # from /home/chiral/work/iteration/ttt-ruby/lib/game.rb:22:in `play_round'
    # from /home/chiral/work/iteration/ttt-ruby/lib/game.rb:14:in `play'
    # from /home/chiral/work/iteration/ttt-ruby/lib/interface.rb:48:in `start_game'
    # from /home/chiral/work/iteration/ttt-ruby/lib/interface.rb:41:in `run_game'
    # from lib/main.rb:5:in `<main>'

    # Interrogating further. Is it because of the zero, or because of the invalid move?

    # Choose a square (1-9):
    # q
    # q is not a valid move.
    # Choose a square (1-9):
    # 5
    # /home/chiral/work/iteration/ttt-ruby/lib/board.rb:21:in `review_move': undefined method `-' for #<Move:0x0056319194b2b8 @spot=5> (NoMethodError)
    # from /home/chiral/work/iteration/ttt-ruby/lib/game.rb:43:in `valid_move?'
    # from /home/chiral/work/iteration/ttt-ruby/lib/game.rb:21:in `play_round'
    # from /home/chiral/work/iteration/ttt-ruby/lib/game.rb:14:in `play'
    # from /home/chiral/work/iteration/ttt-ruby/lib/interface.rb:48:in `start_game'
    # from /home/chiral/work/iteration/ttt-ruby/lib/interface.rb:41:in `run_game'
    # from lib/main.rb:5:in `<main>'

    it "can be reproduced in a test with a string" do
      @player = DeterministicPlayer.new("Player 1", "X", [1, 2, 3, 4, 9])
      @qa_player = DeterministicPlayer.new("Q.A. Player", "#", ["q", 5, 6, 7, 8])
      game = Game.new(player1: @player, player2: @qa_player)
      expect{game.play}.to raise_error NoMethodError
    end

    xit "can be reproduced in a test with an out-of-range int" do
      @player = DeterministicPlayer.new("Player 1", "X", [1, 2, 3, 4, 9])
      @qa_player = DeterministicPlayer.new("Q.A. Player", "#", [0, 5, 6, 7, 8])
      game = Game.new(player1: @player, player2: @qa_player)
      expect{game.play}.to raise_error NoMethodError # This fails, uh, to fail
    end
  end
end
