require "minimax"
require "interface"
require "io"

describe Minimax do
  before(:each) do
    @io = MockIO.new
  end
  it "value of a board with a P1 win is 1" do
    interface = Interface.new(:test_win_player1, @io)
    interface.start_game
    game = interface.game
    expect(Minimax.value(game)).to eq 1
  end
  it "the value of a board with a P2 win is -1" do
    interface = Interface.new(:test_win_player2, @io)
    interface.start_game
    game = interface.game
    expect(Minimax.value(game)).to eq -1
  end
  it "the value of a board with a draw is 0" do
    interface = Interface.new(:test_draw, @io)
    interface.start_game
    game = interface.game
    expect(Minimax.value(game)).to eq 0
  end
end
