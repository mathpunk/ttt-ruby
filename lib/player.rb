class Player
  attr_reader :name
  def initialize(name)
    @name = "Tom"
  end
  def move
    rand(1..9)
  end
  def join(game)
    game.admitPlayer(self)
  end
end
