require "space"

describe Space do

  before(:each) do
    @space = Space.new
  end

  context "new spaces" do

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
      expect(@space.mark(:p1)).to be_truthy
    end
    it "isn't blank after being marked" do
      @space.mark(:p1)
      expect(@space.blank?).to be false
    end
  end

  context "having been marked" do
    before(:each) do
      @space.mark(:p1)
    end

    it "should know who occupies it (player)" do
      expect(@space.owner).to eq(:p1)
      @space.mark(:p2)
      expect(@space.owner).to eq(:p2)
    end

    it "should not be empty" do
      expect(@space.empty?).to be false
    end

    it "should know what occupies it (glyph)" do
      @space.mark(:p1)
      expect(@space.glyph).to eq('X') 
    end
  end

end
