class Player
  attr_reader :mark
  def initialize(name = "Anonymous", mark = "#")
    @name = name
    @mark = nil
  end
  def choose_move(moves)
    possible_moves = (0..2).to_a.product((0..2).to_a).collect { |coord| Move.new(coord) }
    remaining_moves = possible_moves - moves.keys
    move = remaining_moves.sample
    if moves[move] == :no_one
      move
    else
      puts "That square is taken, try another"
      request_move(player)
    end
  end
  def choose_move_io
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
  def request_move(player)
  end
  def request_move_io(player)
  end
end
