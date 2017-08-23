class TicTacToe
  attr_reader :players
  attr_accessor :board

  def column(n)
    @board.select { |key, value| key[1] == n }
  end

  def row(n)
    @board.select { |key, value| key[0] == n }
  end

  def initialize

    @board = Hash.new
    player_1 = "Artoo"
    player_2 = "Hal"
    @players = [player_1, player_2]

    def make_move(player, move)
      # does not forbid overwriting
      @board[move] = player
    end

    def choose_move(player)
      # where the forbidding overwriting (overmoving?) goes
      x = rand(0..2)
      y = rand(0..2)
      move = [x, y]
      if @board[move]
        choose_move(player)
      else
        make_move(player, move)
      end
    end

    def game_over?
      @board.size == 9
    end

    player_to_act = 0
    until game_over?
      choose_move(players[player_to_act])
      player_to_act = (player_to_act + 1) % 2
    end
  end
end
