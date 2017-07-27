require "game"

describe Game do
  it "should create games" do
    game = Game.new
  end

  it "should create playable games" do
    game = Game.new
    game.play
  end

  it "should create winnable games" do
    game = Game.new
    game.over?
  end

  it "should have a result (player or draw) for a game that is over" do
    game = Game.new
    if game.over?
      game.result
    end
  end

  it "should have players" do
    game = Game.new
    game.players
  end
  it "should have a first player" do
    game = Game.new
    game.players[0]
  end
  it "should have a second player" do
    game = Game.new
    expect(game.players[1] == "Tom")
  end
end
