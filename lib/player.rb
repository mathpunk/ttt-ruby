require_relative "move"

class Player
  attr_reader :mark
  def initialize(name = "Anonymous", mark = "#")
    @name = name
    @mark = nil
  end
  def choose_move(board)
    spot = (1..9).to_a.sample
    move = Move.new(spot)
    if board.review_move(move) == :no_one
      move
    else
      choose_move(board)
    end
  end
end

class ConsolePlayer
  def choose_move
    puts "The board looks like: "
    draw_board
    puts "Choose a square: "
    response = gets
    if response
      move = request_move(player)
      puts "Eh that's an ok move, but how about " + move.to_s
    end
    move
  end
end
