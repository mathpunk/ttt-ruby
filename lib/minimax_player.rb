require "player"

class MinimaxPlayer < Player

  attr_reader :preference

  def initialize(preference)
    @preference = preference
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

  def spot_value(game, spot)
    move = Move.new(spot)
    game.imagine_ply(move)
    value = game_value(game)
    if value == :undefined
      opposite_preference = preference == :maximize ? :minimize : :maximize
      imagined_player = MinimaxPlayer.new(opposite_preference)
      what_theyll_play = Move.new(imagined_player.favorite_spot(game))
      game.imagine_ply(what_theyll_play)
      value = game_value(game)
      game.unimagine_ply(what_theyll_play)
    end
    game.unimagine_ply(move)
    value
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

end
