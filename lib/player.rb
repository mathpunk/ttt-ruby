require_relative "move"

class Player
  attr_reader :mark, :name

  def initialize(name = "Anonymous", mark = "#")
    @name = name
    @mark = mark
  end

end

class RandomPlayer < Player
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
  def initialize(name, mark, strategy)
    super(name, mark)
    @strategy = strategy
  end

  def choose_move
    spot = @strategy.shift
    Move.new(spot)
  end

  def peek
    Move.new(@strategy[0])
  end
end
