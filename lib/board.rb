class Board
  def initialize
    @spaces = [:blank,:blank,:blank,:blank,:blank,:blank,:blank,:blank,:blank]
  end
  def empty?
    @spaces.reduce(true) { |result, element| result && element == :blank }
  end
  def size
    @spaces.size
  end
  def move(player, space)
    index = space-1
    @spaces[index] = :mark
  end
end
