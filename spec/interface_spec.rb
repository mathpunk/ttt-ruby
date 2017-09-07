require "io"
require "interface"

describe Interface do
  context "when a game ends" do
    context "in a win" do
      it "announces the win and names the winner" do
        @io = TestIO
        @interface = Interface.new(:test_win, @io)
        expect(@io).to receive(:say).with("Deterministic P1 wins!")
        allow(@io).to receive(:say).with("Play again? (y/n)")
        allow(@io).to receive(:say).with("Thanks for playing!")
        @interface.run_game
      end
    end

    context "in a cat's game" do
      it "announces the draw" do
        @io = TestIO
        @interface = Interface.new(:test_draw, @io)
        expect(@io).to receive(:say).with("It's a draw!")
        allow(@io).to receive(:say).with("Play again? (y/n)")
        allow(@io).to receive(:say).with("Thanks for playing!")
        @interface.run_game
      end
    end

    it "asks if you'd like to play again" do
      @io = TestIO
      @interface = Interface.new(:test_draw, @io)
      allow(@io).to receive(:say).with("Thanks for playing!")
      allow(@io).to receive(:say).with("Deterministic P1 wins!")
      allow(@io).to receive(:say).with("It's a draw!")
      expect(@io).to receive(:say).with("Play again? (y/n)")
      expect(@io).to receive(:ask)
      @interface.run_game
    end
  end

end
