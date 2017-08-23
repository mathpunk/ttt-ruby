require "referee"
require "board"
require "move"

describe Referee do
  before(:each) do
    @board = Board.empty
    @referee = Referee.new(@board)
  end
  it "declares no winner when the board is empty" do
    expect(@referee.winner).to be_nil
  end
  it "declares a winner (perhaps 'draw'?) when the board is full" do
    (1..9).each do |n|
      move = Move.new("Tom", n)
      @board.move(move)
    end
    expect(@referee.winner).not_to be_nil
  end
end
