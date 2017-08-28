require "display"
require "tic_tac_toe"

describe Display do
  before(:each) do
    @game = Game.new
    @board = Board.new
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @game.start(@player1, @player2)
    @display = Display.new(@board)
  end
  it "empty boards look right" do
    board = @display.view
    expect(board).to include("   |   |   \n")
    expect(board).to include("\n---+---+---\n")
  end
  it "has an image of marks after a move" do
    @game.accept_move([0,0], @player1)
    expect(@display.view).to include(" X |   |   ")
  end
end
