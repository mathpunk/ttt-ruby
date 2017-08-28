class Player
  attr_reader :mark
  def initialize
    @mark = nil
  end
  def choose_mark(mark)
    @mark = mark
  end
end
