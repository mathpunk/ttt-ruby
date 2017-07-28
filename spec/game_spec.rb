require "game"
require "player"

describe Game do
  before(:each) do
    @p1 = Player.new(1)
    @p2 = Player.new(2)
    @game = Game.new(@p1, @p2)
  end

  it "should create playable games" do
    expect(@game.play).to be_truthy
  end

  it "should create winnable games" do
    expect(@game.over?).to be_truthy
  end

  it "should have a result (player or draw) for a game that is over" do
    if @game.over?
      expect(@game.result).to_not be_nil
    end
  end

  it "should have exactly 2 players" do
    expect(@game.players.size).to eq(2)
    expect(@game.players[0].class).to eq(Player)
    expect(@game.players[1].class).to eq(Player)
  end

  it "should have a board of 9 spaces" do
    expect(@game.board.size).to eq(9)
  end
end
