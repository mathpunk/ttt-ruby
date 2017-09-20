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

  def best_move(game)
    if preference == :maximize
      opposite_preference = :minimize
      favorite_value = 1
    else
      opposite_preference = :maximize
      favorite_value = -1
    end
    spot_values = depth_one_spot_values(game)
    best_spot_value_pair = spot_values.sort_by { |spot, value| value }[0]
    best_spot = best_spot_value_pair[0]
    Move.new(best_spot)
    # victory = spot_values.find { |spot, value| value == favorite_value }
    # if victory
    #   Move.new(victory[0])
    # else

    # end
  end

  def depth_one_spot_values(game)
    evaluation = available_spots(game).reduce({}) do |valuations, spot|
      move = Move.new(spot)
      game.imagine_ply(move)
      value = game_value(game)
      game.unimagine_ply(move)
      valuations[spot] = value
      valuations
    end
    evaluation
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

  def current_player_preference(game)
    game.player(:current) == game.player(1) ? :maximize : :minimize
  end

  def spot_value(game, spot)
    move = Move.new(spot)
    game.imagine_ply(move)
    if game.over?
      value = self.game_value(game)
      game.unimagine_ply(move)
      value
    else
      search_space = available_spots(game)
      evaluation = {}
      search_space.collect do | spot |
        evaluation[spot] = spot_value(game, spot)
      end
      their_ranking_method = current_player_preference(game) == :maximize ? :reverse : :itself
      their_ranked_pairs = evaluation.sort_by { |pair| pair[1] }.send(their_ranking_method)
      their_ranked_pairs.first[1]
    end
  end

end
