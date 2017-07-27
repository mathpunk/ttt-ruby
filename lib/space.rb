class Space

  def initialize
    @mark = :blank
  end

  def blank?
    @mark == :blank
  end

  def empty? # alias: board uses 'empty?', should this match or differ?
    self.blank?
  end

  def mark(player) # verb
    @mark = player
  end

  def owner
    if @mark
      @mark
    else
      nil
    end
  end

  def glyph
    if @mark == :blank
      ' '
    end
  end

end
