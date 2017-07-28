class Player
  def initialize(position)
    @name = 'Anonymous'
    @position = position
    @glyph = @position == 1 ? 'X' : 'O'
  end

  def name
    @name
  end

  def glyph
    @glyph
  end

  def position
    @position
  end

  def move
    5 # "Good ol' center. nothing beats center."
  end
end
