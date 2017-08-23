require "main"

describe TicTacToe do
  before(:each) do
    @ttt = TicTacToe.new
  end
  it "has two players" do
    expect(@ttt.players.size).to eq(2)
  end
  it "can get columns" do
    (0..2).each do |n|
      column = @ttt.column(n)
      expect(column.class).to eq(Hash)
      expect(column.size).to be <= 3
    end
  end
  it "can get rows" do
    (0..2).each do |n|
      row = @ttt.row(n)
      expect(row.class).to eq(Hash)
      expect(row.size).to be <= 3
    end
  end
end
