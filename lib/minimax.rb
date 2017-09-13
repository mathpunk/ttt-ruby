class Minimax
  def self.value(game)
    imagined_game = game.clone
    player1 = game.player(1)
    player2 = game.player(2)
    if imagined_game.winner == player1
      1
    elsif imagined_game.winner == player2
      -1
    elsif imagined_game.winner == :no_one && imagined_game.over?
      0
    else
      :undefined
    end
  end
end
