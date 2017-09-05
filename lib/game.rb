require "observer"
require_relative "player"
require_relative "board"

class Game
  include Observable
  attr_reader :board, :display

  def initialize(player1:, player2:)
    @board = Board.new
    @players = [player1, player2]
    @current_player = 0
    @display = Display.new(self, @board)
    changed
    notify_observers
  end

  def play
    until over?
      play_round
    end
    end_game
  end

  def play_round
    current_player = player(:up)
    chosen_move = request_move(current_player)
    board.accept_move(current_player, chosen_move)
    @current_player = (@current_player + 1) % 2
  end

  def player(question)
    case question
    when 1
      players[0]
    when 2
      players[1]
    when :up
      players[current_player]
    end
  end

  def accept_move(player, move)
    board.accept_move(player, move)
  end

  def review_move(move)
    board.review_move(move)
  end

  def request_move(player)
    move = player.choose_move
    if board.review_move(move) == :no_one
      move
    else
      reject_move(player)
    end
  end

  def reject_move(player)
    puts "That square is occupied. Choose another."
    request_move(player)
  end

  def over?
    winner != :no_one || board.moves.all? { |occupant| occupant != :no_one }
  end

  def winner
    winner = board.lines.detect { |line| winner_of_line(line) }
    winner ? winner[0] : :no_one
  end

  private
  def winner_of_line(line)
    if line.nil? || line.size < 3
      nil
    else
      if line.all? { |occupant| occupant == line[0] }
        line[0]
      else
        nil
      end
    end
  end

  def end_game
    # display responsibility
    if winner == :no_one
      puts "It's a draw!"
    else
      puts "#{winner.name} wins!"
    end
  end

  private
  attr_accessor  :players, :current_player

end
