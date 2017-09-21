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
    Minimax.what_if(game, spot) do
      @value = Minimax.game_value(game)
      if @value == :undefined
        opposite_preference = preference == :maximize ? :minimize : :maximize
        imagined_player = MinimaxPlayer.new(opposite_preference)
        what_theyll_play = imagined_player.best_response(game)
        @value = spot_value(game, what_theyll_play, opposite_preference)
      end
    end
    @value
  end

  def self.best_response(game, preference)
    sort_method = preference == :minimize ? :itself : :reverse
    spots = game.available_spots
    spot_value_pairs = spots.reduce({}) do |valuations, spot|
      valuations[spot] = spot_value(game, spot, preference)
      valuations
    end
    ranked_spot_value_pairs = spot_value_pairs.sort_by { |spot, value| value }.send(sort_method)
    best_pair = ranked_spot_value_pairs.first
    best_pair[0]
  end

end

class MinimaxPlayer < Player

  attr_reader :preference, :game

  def initialize(name = "Anonymous", mark = "#", preference)
    @preference = preference
  end

  def observe_game(game)
    @game = game
  end

  def spot_value(game, spot)
    Minimax.spot_value(game, spot, preference)
  end

  def best_response(game)
    Minimax.best_response(game, preference)
  end

  def choose_move
    spot = best_response(game)
    puts "#{self.name} plays at @#{spot}"
    Move.new(spot)
  end
end
