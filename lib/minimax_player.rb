require_relative "player"

class MinimaxPlayer < Player

  attr_reader :preference, :game

  def initialize(name = "Anonymous", mark = "#", preference)
    @preference = preference
  end

  def observe_game(game)
    @game = game
  end

  def available_spots(game)
    (1..9).select do |spot|
      move = Move.new(spot)
      game.valid_move? move
    end
  end

  def game_value(game)
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

  def subjunctive_result(game, spot)
    move = Move.new(spot)
    current_player = game.player(:current)
    game.board.accept_move(current_player, move)
    game.advance_turn
    outcome = yield
    game.advance_turn
    game.board.undo_move(move)
    outcome
  end

  def spot_value(game, spot)
    subjunctive_result(game, spot) do
      @value = game_value(game)
      if @value == :undefined
        opposite_preference = preference == :maximize ? :minimize : :maximize
        imagined_player = MinimaxPlayer.new(opposite_preference)
        what_theyll_play = imagined_player.favorite_spot(game)
        @value = spot_value(game, what_theyll_play)
      end
    end
    @value
  end

  def favorite_spot(game)
    sort_method = preference == :minimize ? :itself : :reverse
    spots = available_spots(game)
    spot_value_pairs = spots.reduce({}) do |valuations, spot|
      valuations[spot] = spot_value(game, spot)
      valuations
    end
    ranked_spot_value_pairs = spot_value_pairs.sort_by { |spot, value| value }.send(sort_method)
    best_pair = ranked_spot_value_pairs.first
    best_pair[0]
  end

  def choose_move
    spot = favorite_spot(game)
    Move.new(spot)
  end
end
