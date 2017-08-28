class Player
  attr_reader :mark
  def initialize(name = "Anonymous", mark = "#")
    @name = name
    @mark = nil
  end
end
