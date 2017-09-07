require "io"
require "interface"

describe Interface do
  before(:each) do
    @io = MockIO.new
  end

  context "in interactive mode" do

    context "when choosing players" do

      it "asks for player 1's name" do
        io = MockIO.new(answers: ["", ""])
        interface = Interface.new(:interactive, io)
        message = "Enter name of player 1, or leave blank for a computer player: "
        expect(io.messages).to include message
      end
      it "asks for player 2's name" do
        io = MockIO.new(answers: ["", ""])
        interface = Interface.new(:interactive, io)
        message = "Enter name of player 2, or leave blank for a computer player: "
        expect(io.messages).to include message
      end

      context "and given no names" do
        it "sets player 1 to be a random player" do
          io = MockIO.new(answers: ["", ""])
          interface = Interface.new(:interactive, io)
          expect(interface.player(1).class).to be RandomPlayer
        end
        it "sets player 2 to be a random player" do
          io = MockIO.new(answers: ["", ""])
          interface = Interface.new(:interactive, io)
          expect(interface.player(2).class).to be RandomPlayer
        end
      end

      context "and given names" do

        xit "sets player 1 to be a console player" do
          io = MockIO.new(answers: ["Tom", ""])
          interface = Interface.new(:interactive, io)
          expect(interface.player(1).class).to be ConsolePlayer
        end

        xit "sets player 1's name" do
          io = MockIO.new(answers: ["Tom", ""])
          interface = Interface.new(:interactive, io)
          expect(interface.player(1).name).to eq "Tom"
        end

        xit "sets player 2 to be a console player" do
          io = MockIO.new(answers: ["", "Tom"])
          interface = Interface.new(:interactive, io)
          expect(interface.player(2).class).to be ConsolePlayer
        end

        xit "sets player 2's name" do
          io = MockIO.new(answers: ["", "Tom"])
          interface = Interface.new(:interactive, io)
          expect(interface.player(2).name).to eq "Tom"
        end
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

    it "responds to new game refusal politely" do
      # Note that MockIO currently responds "n" to all questions
      @interface = Interface.new(:test_draw, @io)
      @interface.run_game
      expect(@io.messages).to include("Thanks for playing!")
    end
  end

end
