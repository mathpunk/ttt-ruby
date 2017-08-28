require "display"
require "tic_tac_toe"

describe Display do
  before(:each) do
    @game = Game.new
    @player1 = Player.new
    @player1.choose_mark("X")
    @player2 = Player.new
    @player2.choose_mark("O")
    @game.start(@player1, @player2)
    @display = Display.new(@game)
  end
  it "has an image of marks after a move" do
    @game.accept_move([0,0], @player1)
    expect(@display.view).to include(" X |   |   ")
  end
end
