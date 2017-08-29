require "display"
require "tic_tac_toe"
require "move"

describe Display do
  before(:each) do
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @game = Game.new(@player1, @player2)
    @board = @game.board
    @display = @game.display
  end
  it "empty boards look right" do
    board = @display.view
    expect(board).to include("   |   |   \n")
    expect(board).to include("\n---+---+---\n")
  end
  it "has an image of marks after a move" do
    @game.accept_move(@player1, Move.new([0, 0]))
    expect(@display.view).to include(" X |   |   ")
  end
  describe 'board_cells' do
    it 'adds a move to the cell array' do
      moves = Hash.new(:no_one)
      move = Move.new(0,0)
      moves[move] = @player1
      cells = @display.board_cells(moves)
      expect(cells[0]).to eql(' X ')
    end
  end
  describe 'draw_board' do
    it 'will draw an board with a move in it' do
      moves = Hash.new(:no_one)
      move = Move.new(0,1)
      moves[move] = @player1
      expect(@display.draw_board(moves)).to include(" X |   |   ")
    end
  end
  describe 'update' do
    it 'empty boards have empty rows when updated' do
      moves = Hash.new(:no_one)
      @display.update(moves)
      expect(@display.view).to include("   |   |   \n")
    end
    it 'draws the right update given a collection of moves' do
      moves = Hash.new(:no_one)
      move = Move.new(0,1)
      moves[move] = @player1
      @display.update(moves)
      expect(@display.view).to include("   | X |   ")
    end
  end
end

