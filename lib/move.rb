class IllFormedMoveError < StandardError
end

class Move
  attr_reader :spot

  def initialize(spot)
    unless spot.class == Integer && spot > 0 && spot < 10
      raise IllFormedMoveError
    else
      @spot = spot
    end
  end
end
