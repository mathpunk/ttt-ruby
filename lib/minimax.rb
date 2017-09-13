require "move"

class Minimax

  def self.value(game)
    player1 = game.player(1)
    player2 = game.player(2)
    if game.winner == player1
      1
    elsif game.winner == player2
      -1
    elsif game.winner == :no_one && game.over?
      0
    else
      :undefined
    end
  end

  def self.move_value(game, player, spot)
    imagined_game = game.clone
    imagined_move = Move.new(spot)
    imagined_game.board.accept_move(player, imagined_move)
    Minimax.value(imagined_game)
  end

end
