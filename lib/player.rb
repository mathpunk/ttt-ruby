require_relative "move"

class Player
  attr_reader :mark, :name

  def initialize(name = "Anonymous", mark = "#")
    @name = name
    @mark = mark
  end

  def choose_move
    spot = (1..9).to_a.sample
    Move.new(spot)
  end

end

class ConsolePlayer < Player
  def choose_move
    puts "Choose a square (1-9): "
    response = gets.chomp
    spot = conform_move(response)
    Move.new(spot)
  end

  def conform_move(choice)
    spot = choice.to_i
    unless (1..9).include? spot
      puts "#{choice} is not a valid move."
      choose_move
    else
      spot
    end
  end
end

class DeterministicPlayer < Player

  def initialize(position)
    if position == 1
      super("Deterministic P1", "X")
      @strategy = [1, 9, 4, 7]
    elsif position == 2
      super("Deterministic P2", "O")
      @strategy = [5, 2, 3]
    end
  end

  def choose_move
    spot = @strategy.shift
    Move.new(spot)
  end

  def peek
    Move.new(@strategy[0])
  end
end

class DrawingDeterministicPlayer < DeterministicPlayer

  def initialize(position)
    if position == 1
      super(position)
      @strategy = [1, 2, 7, 6, 9]
    elsif position == 2
      super(position)
      @strategy = [5, 3, 4, 8]
    end
  end

end
