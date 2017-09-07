require "ceremony"
require "player"

describe Ceremony do
  before(:each) do
    @mock_io = double
    @ceremony = DeterministicCeremony.new(@mock_io)
  end

  context "on start of ceremony" do
    xit "says a welcome message" do
      message = "Are you ready for some Tic... Tac... Toooooe!!?!!?!!?"
      expect(@mock_io).to receive(:say).and_return(message)
      @ceremony.start_ceremony
    end
  end

  context "when gathering players" do
    xit "says something" do
    end
  end

  context "on beginning the game" do

    xit "makes an announcement" do
      allow(@mock_io).to receive(:say)
      @ceremony.gather_players
      message = "Let's begin!"
      expect(@mock_io).to receive(:say).and_return(message)
      @ceremony.start_game
    end
  end

  context "in a game with a winner" do
    xit "announces the winner" do
      allow(@mock_io).to receive(:say)
      @ceremony.gather_players
      expect(@mock_io).to receive(:say).and_return("Fish fingers and custard")
      @ceremony.start_game
    end
  end

  xit "watches for a conclusion" do
    message = "It's a draw!"
    expect(@mock_io).to receive(:say).and_return(message)
    expect(@ceremony).to receive(:announce_winner)
    allow(@mock_io).to receive(:say)
    @ceremony.start_game
  end

end
