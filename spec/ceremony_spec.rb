require "ceremony"

# Intended API
# ===================

# Public
# -------------------
# conduct

# Private (components of the ceremony)
# ------------------------------------------
# initiate
# gather_players
# start_game
# request_turn
# acknowledge_turn
# announce_winner
# play_again_shall_we
# change_it_up_shall_we

describe Ceremony do
  before(:each) do
    @mock_io = double
    @ceremony = Ceremony.new(@mock_io)
  end

  context "conducting the game ceremony" do

    it "has a welcome message" do
      message = "Are you ready for some Tic... Tac... Toooooe!!?!!?!!?"
      expect(@mock_io).to receive(:say).and_return(message)
      @ceremony.begin
    end

    xit "gathers the players" do
      # expect two calls of Player.new
      # expects those players to be asked for their names and marks
      # allows for Human or Computer players
      # @ceremony.gather_players
    end

    it "announces the beginning of a game" do
      message = "Let's begin!"
      expect(@mock_io).to receive(:say).and_return(message)
      @ceremony.start_game
    end

    it "announces the conclusion" do
      message = "It's a draw!"
      expect(@mock_io).to receive(:say).and_return(message)
      # expect(@ceremony).to receive(:announce_winner)
      @ceremony.start_game
    end

  end

  # observing the game
  # restarting the game
end
