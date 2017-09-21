require_relative "game"
require_relative "player"
require_relative "minimax_player"

class Interface
  attr_reader :game
  def initialize(mode, io)
    case mode
    when :interactive
      @io = io
      # @players = [1, 2].collect { |position| create_human_or_random_player_interactively(position) }
      @players = [1, 2].collect do |position|
        create_human_or_minimax_player_interactively(position)
      end
    when :test_win_player1
      player1 = DeterministicPlayer.new("Deterministic P1", "X", [1, 9, 4, 7])
      player2 = DeterministicPlayer.new("Deterministic P2", "O", [5, 2, 3, 8])
      @players = [player1, player2]
      @io = io
    when :test_win_player2
      player1 = DeterministicPlayer.new("Deterministic P1", "X", [5, 2, 3, 6, 7])
      player2 = DeterministicPlayer.new("Deterministic P2", "O", [1, 9, 4, 7])
      @players = [player1, player2]
      @io = io
    when :test_draw
      player1 = DeterministicPlayer.new("Deterministic P1", "X",[1, 2, 7, 6, 9])
      player2 = DeterministicPlayer.new("Deterministic P2", "O", [5, 3, 4, 8])
      @players = [player1, player2]
      @io = io
    end
  end

  def create_human_or_random_player_interactively(position)
    player_name = io.query("Enter name of player #{position}, or leave blank for a computer player: ")
    player_mark = get_valid_player_mark(position)
    if player_name.empty?
      player = RandomPlayer.new("Computer Player #{position}", player_mark)
    else
      player = ConsolePlayer.new(player_name, player_mark)
    end
  end

  def create_human_or_minimax_player_interactively(position)
    player_name = io.query("Enter name of player #{position}, or leave blank for a computer player: ")
    player_mark = get_valid_player_mark(position)
    if player_name.empty?
      preference = position == 1 ? :maximize : :minimize
      player = MinimaxPlayer.new("Computer Player #{position}", player_mark, preference)
    else
      player = ConsolePlayer.new(player_name, player_mark)
    end
  end

  def get_valid_player_mark(position)
    default_mark = position == 1 ? "X" : "O"
    player_mark_response = io.query("Enter mark for player #{position}, or leave blank for '#{default_mark}': ")
    case player_mark_response.size
    when 0
      default_mark
    when 1
      player_mark_response
    else
      io.say("Marks must be a single character. Try again.")
      get_valid_player_mark(position)
    end
  end

  def run_ply
    current_player = player(:current)
    chosen_move = current_player.choose_move
    until valid_move?(chosen_move)
      puts "That square is taken. Choose another."
      chosen_move = current_player.choose_move
    end
    board.accept_move(current_player, chosen_move)
    @current_player = (@current_player + 1) % 2
  end

  def run_game
    start_game
    announce_winner
    play_again_shall_we
  end

  def start_game
    @game = Game.new(player1: player(1), player2: player(2))
    game.play
  end

  def announce_winner
    winner = game.winner
    if winner == :no_one
      io.say "It's a draw!"
    else
      io.say "#{game.winner.name} wins!"
    end
  end

  def play_again_shall_we
    io.say "Play again? (y/n)"
    response = io.ask
    case response
    when "y"
      run_game
    when "Y"
      run_game
    else
      io.say "Thanks for playing!"
    end
  end

  def player(question)
    case question
    when 1
      players[0]
    when 2
      players[1]
    end
  end

  private
  attr_reader :io,  :players

end
