require "io"
require "interface"

describe Interface do
  before(:each) do
    @io = TestIO.new
  end
  context "in interactive mode" do
    context "choosing players" do
      xit "asks for player 1's name" do
      end
      xit "asks for player 2's name" do
      end
      xit "assumes a computer if no name given" do
      end
      xit "...for either player" do
      end
    end
  end

  context "when a game ends" do
    context "in a win" do
      it "announces the win and names the winner" do
        @interface = Interface.new(:test_win, @io)
        @interface.run_game
        expect(@io.messages).to include("Deterministic P1 wins!")
      end
    end

    context "in a cat's game" do
      it "announces the draw" do
        @interface = Interface.new(:test_draw, @io)
        @interface.run_game
        expect(@io.messages).to include("It's a draw!")
      end
    end

    it "asks if you'd like to play again" do
      @interface = Interface.new(:test_draw, @io)
      @interface.run_game
      expect(@io.messages).to include("Play again? (y/n)")
    end
  end

end
