require_relative "board"

class Game
  attr_reader :board

  def initialize(player1:, player2:)
    @board = Board.new
    @players = [player1, player2]
    @current_player = 0
  end

  def play
    until over?
      play_round
    end
  end

  def play_round
    current_player = player(:up)
    chosen_move = current_player.choose_move
    if !valid_move?(chosen_move)
      until valid_move?(chosen_move)
        puts "That square is taken. Choose another."
        chosen_move = current_player.choose_move
      end
    end
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

  def valid_move?(move)
    board.review_move(move) == :no_one
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

  private
  attr_accessor  :players, :current_player

end
