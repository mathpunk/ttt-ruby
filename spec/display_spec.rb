require "display"
require "tic_tac_toe"
require "move"

describe Display do
  before(:each) do
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @game = Game.new(@player1, @player2)
    @board = @game.board
    @display = @game.display
  end
  it "streams to stdout" do
    expect{@display.update}.to output(/.*/).to_stdout
  end
  it "streams to stdout when there's a move" do
    expect{@game.play_round}.to output(/.*/).to_stdout
  end

  context "when beginning" do
    it "prints to the console" do
      expect{Game.new(@player1, @player2)}.to output(/.*/).to_stdout
    end
    it "shows an empty board" do
      empty_board = /"   |   |   \n   |   |   \n   |   |   "/
      expect{Game.new(@player1, @player2)}.to output(empty_board).to_stdout
    end
  end

  context "rows" do
    it "renders move to spot by player one" do
      move = Move.new(1)
      expect{@game.accept_move(@player1, move)}.to output(/ X |   |   /).to_stdout
    end
    it "renders move to coordinate by player two" do
      move = Move.new([1,1])
      expect{@game.accept_move(@player2, move)}.to output(/   | O |   /).to_stdout
    end
  end

  context "when playing" do
    it "shows the first player's mark" do
      expect{@game.play_round}.to output(/X/).to_stdout
    end
    it "shows the second player's mark" do
      @game.play_round
      expect{@game.play_round}.to output(/O/).to_stdout
    end
  end
end
