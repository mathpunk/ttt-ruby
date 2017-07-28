require "space"
require "player"

describe Space do

  before(:each) do
    @space = Space.new
    @p1 = Player.new(1)
    @p2 = Player.new(2)
  end

  context "a new space" do
    it "begins as a blank" do
      expect(@space.blank?).to be true
    end

    it "has empty? as a synonym for blank?" do
      expect(@space.empty?).to be true
    end

    it "have ' ' as their glyph" do
      expect(@space.glyph).to eq(' ')
    end
  end

  context "the act of marking" do
    it "can be marked" do
      expect(@space.mark(@p1)).to be_truthy
    end
    it "isn't blank after being marked" do
      @space.mark(@p1)
      expect(@space.blank?).to be false
    end
  end

  context "having been marked" do
    before(:each) do
      @space.mark(@p1)
      @another_space = Space.new
      @another_space.mark(@p2)
    end

    it "should not be empty" do
      expect(@space.empty?).to be false
    end

    it "should know who occupies it (player)" do
      expect(@space.owner).to eq(@p1)
      expect(@another_space.owner).to eq(@p2)
    end

    it "should know what occupies it (glyph)" do
      expect(@space.glyph).to eq('X') 
    end
  end

end
