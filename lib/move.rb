class Move
  attr_reader :coordinates, :spot
  def initialize(arg1, arg2 = nil)
    if arg1.class == Array && !arg2
      @coordinates = arg1
      @spot = coordinates_to_spot[@coordinates]
    elsif arg1.class == Integer && arg2.class == Integer
      @coordinates = [arg1, arg2]
      @spot = coordinates_to_spot[@coordinates]
    elsif arg1.class == Integer && !arg2
      @spot = arg1
      @coordinates = spot_to_coordinates[@spot]
    else
      :invalid
    end
  end
  def row
    @coordinates[0]
  end
  def column
    @coordinates[1]
  end
  private
  def spot_to_coordinates
    { 1 => [0,0],
      2 => [0,1],
      3 => [0,2],
      4 => [1,0],
      5 => [1,1],
      6 => [1,2],
      7 => [2,0],
      8 => [2,1],
      9 => [2,2] }
  end
  def coordinates_to_spot
    spot_to_coordinates.invert
  end
end
