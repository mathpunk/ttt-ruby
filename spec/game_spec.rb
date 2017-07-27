require "game"

describe Game do
  before(:all) do
    @game = Game.new
  end

  it "should create playable games" do
    @game.play
  end

  it "should create winnable games" do
    @game.over?
  end

  it "should have a result (player or draw) for a game that is over" do
    if @game.over?
      expect(@game.result).to_not be_nil
    end
  end

  it "should have exactly 2 players" do
    expect(@game.players.size).to eq(2)
  end

  it "should have a board of 9 spaces" do
    expect(@game.board.size).to eq(9)
  end
end
