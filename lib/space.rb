class Space

  def initialize
    @owner = nil    # How do we feel about explicit nil assignment?
                    # I wanted to express the intent to use this name and the absence of its value.
  end

  def blank?
    unless @owner
      true
    else
      false
    end
  end

  def empty? # alias: board uses 'empty?', should this match or differ?
    self.blank?
  end

  def mark(player) # verb
    @owner = player
  end

  def glyph
    if self.blank?
      ' '
    else
      @owner.glyph
    end
  end

end
