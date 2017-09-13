require "io"
require "interface"

describe Interface do
  before(:each) do
    @io = MockIO.new
  end

  context "in interactive mode" do

    context "when choosing players" do
      before(:each) do
        @io = MockIO.new(answers: ["", "", "", ""])
        @interface = Interface.new(:interactive, @io)
      end
      it "asks for player 1's name" do
        message = "Enter name of player 1, or leave blank for a computer player: "
        expect(@io.messages).to include message
      end

      it "asks for player 1's mark" do
        io = MockIO.new(answers: ["", "", "", ""])
        message = "Enter mark for player 1, or leave blank for 'X': "
        expect(@io.messages).to include message
      end

      it "asks for player 2's name" do
        io = MockIO.new(answers: ["", "", "", ""])
        message = "Enter name of player 2, or leave blank for a computer player: "
        expect(@io.messages).to include message
      end

      context "and given no names" do
        before(:each) do
          @io = MockIO.new(answers: ["", "", "", ""])
          @interface = Interface.new(:interactive, @io)
        end
        it "sets player 1 to be a random player" do
          expect(@interface.player(1).class).to eq RandomPlayer
        end

        it "sets player 2 to be a random player" do
          expect(@interface.player(2).class).to eq RandomPlayer
        end
      end

      context "and given names" do
        before(:each) do
          @io = MockIO.new(answers: ["Tom", "", "Thomas", ""])
          @interface = Interface.new(:interactive, @io)
        end

        it "sets player 1 to be a console player" do
          expect(@interface.player(1).class).to eq ConsolePlayer
        end

        it "sets player 1's name" do
          expect(@interface.player(1).name).to eq "Tom"
        end

        it "sets player 2 to be a console player" do
          expect(@interface.player(2).class).to eq ConsolePlayer
        end

        it "sets player 2's name" do
          expect(@interface.player(2).name).to eq "Thomas"
        end

      end
    end
    context "and given no marks" do
      before(:each) do
        @io = MockIO.new(answers: ["Tom", "", "Thomas", ""])
        @interface = Interface.new(:interactive, @io)
      end

      it "sets player 1's mark to 'X'" do
        expect(@interface.player(1).mark).to eq "X"
      end

      it "sets player 2's mark to 'O'" do
        expect(@interface.player(2).mark).to eq"O"
      end
    end

    context "and given single-character marks" do
      before(:each) do
        @io = MockIO.new(answers: ["Tom", "+", "Thomas", "0"])
        @interface = Interface.new(:interactive, @io)
      end

      it "sets player 1's mark to the requested mark" do
        expect(@interface.player(1).mark).to eq "+"
      end

      it "sets player 2's mark to the requested mark" do
        expect(@interface.player(2).mark).to eq "0"
      end
    end

    context "and given multi-character marks" do
      before(:each) do
        @io = MockIO.new(answers: ["Tom", "XX", "", "Thomas", "0"])
        @interface = Interface.new(:interactive, @io)
      end
      xit "explains marks must be one character long" do
        message = "Marks cannot be more than one character. Try another one."
        expect(@io.messages).to include message
      end
      it "keeps prodding the player until a valid mark is given" do
        expect(@interface.player(1).mark.size).to eq(1)
      end
    end
  end

  context "when a game ends" do

    context "in a player 1 win" do
      it "announces the win and names player 1 as the winner the winner" do
        @interface = Interface.new(:test_win_player1, @io)
        @interface.run_game
        winner = @interface.player(1)
        announcement = "#{winner.name} wins!"
        expect(@io.messages).to include(announcement)
      end
    end

    context "in a player 2 win" do
      it "announces the win and names player 2 as the winner the winner" do
        @interface = Interface.new(:test_win_player2, @io)
        @interface.run_game
        winner = @interface.player(2)
        announcement = "#{winner.name} wins!"
        expect(@io.messages).to include(announcement)
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
