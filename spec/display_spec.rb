require "player"
require "game"

describe Display do
  before(:each) do
    @player1 = DeterministicPlayer.new("Deterministic P1", "X", [1, 9, 4, 7])
    @player2 = DeterministicPlayer.new("Deterministic P2", "O", [5, 2, 3])
    @game = Game.new(player1: @player1, player2: @player2)
    @board = @game.board
  end
  it "streams to stdout when a round is played" do
    expect{@game.play_round}.to output(/.*/).to_stdout
  end

  context "when beginning a game" do
    it "prints to the console" do
      expect{Game.new(player1: @player1, player2: @player2)}.to output(/.*/).to_stdout
    end
    it "shows an empty board" do
      empty_board = /"   |   |   \n   |   |   \n   |   |   "/
      expect{Game.new(player1: @player1, player2: @player2)}.to output(empty_board).to_stdout
    end
  end

  context "during play" do
    it "places player one's mark correctly in its row" do
      expect{@game.play_round}.to output(/ X |   |   /).to_stdout
    end
    it "places player two's mark correctly in its row" do
      @game.play_round
      expect{@game.play_round}.to output(/   | O |   /).to_stdout
    end
    it "places player one's mark correctly on the board" do
      expect{@game.play_round}.to output(/ X |   |   \n   |   |   \n   |   |   /).to_stdout
    end
    it "places player two's mark correctly on the board" do
      @game.play_round
      expect{@game.play_round}.to output(/ X |   |   \n   | O |   \n   |   |   /).to_stdout
    end
  end
end
