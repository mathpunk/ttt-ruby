require_relative "player"

class Minimax

  def self.what_if(game, spot)
    move = Move.new(spot)
    current_player = game.player(:current)
    game.board.accept_move(current_player, move)
    game.advance_turn
    outcome = yield
    game.advance_turn
    game.board.undo_move(move)
    outcome
  end

  def self.game_value(game)
    maximizer = game.player(1)
    minimizer = game.player(2)
    if !game.over?
      :undefined
    elsif game.winner == maximizer
      1
    elsif game.winner == minimizer
      -1
    elsif game.winner == :no_one
      0
    end
  end

  def self.spot_value(game, spot, preference)
    value = nil
    Minimax.what_if(game, spot) do
      value = Minimax.game_value(game)
      if value == :undefined
        opponent_preference = preference == :maximize ? :minimize : :maximize
        opponent_response = Minimax.best_response(game, opponent_preference)
        value = spot_value(game, opponent_response, opponent_preference)
      end
    end
    value
  end

  def self.best_response(game, preference)
    sort_method = preference == :minimize ? :itself : :reverse
    spot_value_pairs = game.available_spots.reduce({}) do |valuations, spot|
      valuations[spot] = spot_value(game, spot, preference)
      valuations
    end
    ranked_spot_value_pairs = spot_value_pairs.sort_by { |spot, value| value }.send(sort_method)
    ranked_spot_value_pairs.first[0]
  end

end

class MinimaxPlayer < Player

  attr_reader :preference, :game

  def initialize(name = "Anonymous", mark = "#", preference)
    @preference = preference
  end

  def join_game(game)
    @game = game
    @preference = game.player1 == self ? :maximize : :minimize
  end

  def spot_value(game, spot)
    Minimax.spot_value(game, spot, preference)
  end

  def best_response(game)
    Minimax.best_response(game, preference)
  end

  def choose_move
    spot = best_response(game)
    puts "#{self.name} plays at #{spot}"
    Move.new(spot)
  end
end
