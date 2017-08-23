require "referee"
require "player"
require "board"

class Game
  attr_reader :board, :winner, :players

  def initialize()
    @board = Board.empty
    @players = Hash.new
    referee = Referee.new(@board)
    referee.add_observer(self)
  end
  def conclusion
    if winner
      winner + " wins!"
    else
      nil
    end
  end
  def admitPlayer(player)
    if players.size == 0
      players[1] = player
    elsif players.size == 1
      players[2] = player
    else
      nil
    end
  end
  def update(referee)
    @winner = referee.winner
  end
  def player(number)
    players[number]
  end
end
