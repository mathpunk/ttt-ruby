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

  def self.move_value(game, player, move)
    imagined_game = game.clone
    imagined_game.board.accept_move(player, move)
    Minimax.value(imagined_game)
  end

  def self.valid_moves(game)
    moves = (1..9).collect { |n| Move.new(n) }
    moves.select do |move|
      game.valid_move?(move)
    end
  end

  def self.maxima(game, player)
    moves_to_check = valid_moves(game)
    valuation = {}
    moves_to_check.each do |move|
      valuation[move] = Minimax.move_value(game, player, move)
    end
    moves_ranked = valuation.sort_by { |move, value| value }.reverse
    moves_ranked
  end
end

