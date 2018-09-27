require 'game'

describe Game do
  subject(:game) { Game.new }

  before do
    game.new_player('Pupe')
    game.new_player('Toto')
  end

  describe '#new_player creates a player' do
    context "when 2 player" do
      context "First player is Pupe and her mark it's a red circle" do
        it 'creates it' do
          expect(game.player_one.name).to eq('Pupe')
          expect(game.player_one.mark).to eq("\e[31m\u26ab\e[0m")
        end
      end

      context "Second player is Toto and his mark it's a yellow circle" do
        it 'creates it' do
          expect(game.player_two.name).to eq('Toto')
          expect(game.player_two.mark).to eq("\e[33m\u26ab\e[0m")
        end
      end
    end
  end

  describe '#board is an instance of GameBoard' do
    it 'tracks the board state' do
      expect(game.board.grid).to be_kind_of(Array)
    end
  end

  describe '#move puts the current player marker on the chosen column' do
    context 'when a red marker is put in the first column' do
      before { game.move(1) }

      it 'falls on the first subarray with a red piece' do
        expect(game.board.grid[0][0]).to eq("\e[31m\u26ab\e[0m")
      end
    end

    context 'when the column already has 6 pieces' do
      before do
        3.times { game.move(2) }
        game.switch_player
        3.times { game.move(2) }
      end

      it "will ask for another argument and call the method again" do
        allow(game).to receive(:gets).and_return(1)
        expect(game.move(2)).to eq(0)
      end
    end

    context 'when the column doesn\'t exist' do
      it 'will ask for another argument and call the method again' do
        allow(game).to receive(:gets).and_return(7)
        expect(game.move(10)).to eq(6)
      end
    end
  end

  describe '#column_win? checks for 4 connected pieces vertically' do
    context 'when the last 4 pieces are the same' do
      before { 4.times { game.move(3) } }

      it 'returns the current player' do
        expect(game.column_win?).to be true
      end
    end

    context 'when there are 4 pieces of the same color but not in a row' do
      before do
        3.times { game.move(2) }
        game.switch_player
        game.move(2)
        game.switch_player
        game.move(2)
      end
      it 'returns false' do
        expect(game.column_win?).to be false
      end
    end

    context 'when the column is smaller than 4' do
      before { 3.times { game.move(6) } }
      it 'returns false' do
        expect(game.column_win?).to be false
      end
    end
  end

  describe '#row_win? checks for 4 conected pieces horizontally' do
    context 'when first row has 4 in a row' do
      before do
        game.move(1)
        game.move(2)
        game.move(3)
        game.move(4)
      end

      it 'returns current player' do
        expect(game.row_win?).to be true
      end
    end

    context 'when there are 4 of the same mark but not connected' do
      before do
        game.move(1)
        game.move(2)
        game.move(3)
        game.move(5)
      end

      it 'returns false' do
        expect(game.column_win?).to be false
      end
    end
  end

  describe '#diagonal_win? checks for 4 connected pieces diagonally' do
    context 'when 4 are connected' do
      before do
        game.move(2)
        2.times { game.move(3) }
        3.times { game.move(4) }
        game.switch_player
        game.move(1)
        game.move(2)
        game.move(3)
        game.move(4)
      end

      it 'returns current player' do
        expect(game.diagonal_win?).to be true
      end
    end

    context 'when 4 are present but not connected' do
      before do
        game.move(2)
        3.times { game.move(3) }
        3.times { game.move(4) }
        game.switch_player
        game.move(1)
        game.move(3)
        game.move(4)
        game.move(5)
      end

      it 'returns false' do
        expect(game.diagonal_win?).to be false      
      end
    end
  end

  describe '#end_check checks if a game ending condition has been met' do
    context 'when a player connects four' do
      context 'vertically uses #column_win?' do
        before { 4.times { game.move(1) } }

        it 'assigns victory to @player_one' do
          expect { game.end_check }.to output("Pupe connected four! Pupe WINS THE GAME\n").to_stdout
        end          
      end

      context 'horizontally uses #row_win?' do
        before do
          game.move(1)
          game.move(2)
          game.move(3)
          game.move(4)
        end

        it 'assigns victory to @player_one' do
          expect { game.end_check }.to output("Pupe connected four! Pupe WINS THE GAME\n").to_stdout
        end
      end

      context 'diagonally #diagonal_win?' do
        before do
          game.move(2)
          2.times { game.move(3) }
          3.times { game.move(4) }
          game.switch_player
          game.move(1)
          game.move(2)
          game.move(3)
          game.move(4)
        end

        it 'assigns victory to @player_two' do
          expect { game.end_check }.to output("Toto connected four! Toto WINS THE GAME\n").to_stdout
        end
      end
    end

    context 'when there is no more space on the grid ' do
      before do
        game.board.grid = Array.new(7) { Array.new(6) { 6 } }
      end

      it "returns 'tie'" do
        expect { game.end_check }.to output("The board is full, it's a TIE\n").to_stdout
      end
    end

    context 'when no game ending condition has been met' do
      before { game.move(1) }
      it 'returns nil' do
        expect(game.end_check).to be_nil
      end
    end
  end

  describe '#end_game informs of the game ending condition' do
    context 'when game is a tie' do
      it 'informs of it and exits the program' do
        expect { game.end_game('tie') }.to output("The board is full, it's a TIE\n").to_stdout
      end
    end

    context 'when current Player wins' do
      it 'informs congratulates the player and exits the program' do
        expect { game.end_game(game.playing.name) }.to output("Pupe connected four! Pupe WINS THE GAME\n").to_stdout
      end
    end
  end
end
