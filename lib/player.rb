require_relative "move"

class Player
  attr_reader  :name
  attr_accessor :mark

  def initialize(name = "Anonymous", mark = "#")
    @name = name
    @mark = mark
  end

  def join_game(game)
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
    conform_move(response)
  end

  def conform_move(response)
    choice = coerced_integer(response)
    if response.size == 0
      puts "You must make a move."
      choose_move
    elsif choice && choice > 0 && choice < 10
      Move.new(choice)
    else
      puts "Moves must be numbers, between 1 and 9."
      choose_move
    end
  end

  private
  def coerced_integer(string)
    integer = string.to_i
    if integer.to_s == string
      return integer
    else
      nil
    end
  end
end

class DeterministicPlayer < Player
  def initialize(name = "Determinist", mark = "#", strategy)
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

