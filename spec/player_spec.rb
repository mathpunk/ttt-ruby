require "player"

describe Player do

  before(:each) do
    @p1 = Player.new(1)
    @p2 = Player.new(2)
  end

  context "any player" do
    it "should have a non-empty name string" do
      expect(@p1.name.class).to eq(String)
      expect(@p1.name.size).to be > 0
    end

    it "should have a 1-character glyph string" do
      expect(@p1.glyph.class).to eq(String)
      expect(@p1.glyph.size).to eq(1)
    end
  end

  context "player 1 and player 2" do
    it "should have the right position" do
      expect(@p1.position).to eq(1)
      expect(@p2.position).to eq(2)
    end

    it "should have the traditional glyphs as defaults" do
      expect(@p1.glyph).to eq('X')
      expect(@p2.glyph).to eq('O')
    end
  end

  context "player movement" do
    it "should be a valid address for a space" do
      expect(@p1.move).to be_between(1,9).inclusive
    end
  end

end
