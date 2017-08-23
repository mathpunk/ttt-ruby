require "observer"

class Referee
  include Observable
  attr_reader :board, :winner
  def initialize(board)
    board.add_observer(self)
    @winner = nil
  end
  def update(board)
    if board.full?
      @winner = "Tom"
      changed
      notify_observers(self)
    end
  end
end
