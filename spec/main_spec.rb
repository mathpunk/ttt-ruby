require "main"

describe TicTacToe do
  before(:each) do
    @ttt = TicTacToe.new
  end
  it "is a class" do
    expect(@ttt).to be_truthy
  end
  it "has data" do
    expect(@ttt.board).to be_truthy
  end
  it "has two players" do
    expect(@ttt.players.size).to eq(2)
  end
  it "ends only when all cells are full" do
    expect(@ttt.board.size).to eq(9)
  end
end
