class Move
  attr_reader :who, :where
  def initialize(who, where)
    @who = who
    @where = where
  end
end
