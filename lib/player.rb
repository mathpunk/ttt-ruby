require_relative "move"

class Player
  attr_reader :mark

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
    response = gets
    validate_move(response)
    Move.new(response)
  end

  def validate_move(choice)
    unless (1..9).include? choice
      puts "#{choice} is not a valid move."
      choose_move
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
      @strategy = [5, 2, 3, 8]
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
