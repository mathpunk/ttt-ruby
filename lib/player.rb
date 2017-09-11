require_relative "move"

class Player
  attr_reader  :name
  attr_accessor :mark

  def initialize(name = "Anonymous", mark = "#")
    @name = name
    @mark = mark
  end

end

class RandomPlayer < Player
  def choose_move
    spot = (1..9).to_a.sample
    puts "#{self.name} chooses #{spot}."
    Move.new(spot)
  end
end

class ConsolePlayer < Player
  def choose_move
    puts "Choose a square, #{self.name} (1-9): "
    response = gets.chomp
    spot = conform_move(response)
    Move.new(spot)
  end

  def conform_move(response)
    if response.size == 0
      puts "You must make a move."
      choose_move
    end
    choice = response.to_i
    if choice == 0
      puts "#{response} is not a valid move."
      choose_move
    end
    unless (1..9).include? choice
      puts "#{choice} is not a valid move."
      choose_move
    else
      choice
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
