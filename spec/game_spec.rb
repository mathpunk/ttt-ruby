require "game"
require "move"
require "mc"

describe Game do
  before(:each) do
    @game = Game.new
  end
  context "when initialized (as an object)" do
    it "has no winner" do
      expect(@game.winner).to be_falsey
    end
    it "cannot be won in fewer than 5 moves" do
      4.times do |n|
        move = Move.new("someone", n)
        @game.board.move(move)
        expect(@game.winner).to be_falsey
      end
    end
    it "must have a conclusion in 9 moves or fewer" do
      9.times do |n|
        move = Move.new("someone", n)
        @game.board.move(move)
      end
      expect(@game.winner).to be_truthy
    end
  end
  context "when beginning (with ceremony)" do
    before(:each) do
      @game = MC.openingCeremony
    end
    it "has two players: player(1) and player(2)" do
      expect(@game.players.size).to eq(2)
      expect(@game.player(1)).to be_truthy
      expect(@game.player(2)).to be_truthy
    end
  end
end
