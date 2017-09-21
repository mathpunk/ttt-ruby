class Display
  def self.display_observing(board:)
    display = new(board)
    board.add_observer(display)
    display.update
  end

  def initialize(board)
    @board = board
  end

  def update
    puts board.to_s
  end

  private
  attr_reader :board

end
