require 'game_board'

describe GameBoard do
  subject(:gameboard) { GameBoard.new }

  describe '#grid stores the board state' do
    context 'when object is created' do
      it 'is an array with 7 empty sub arrays' do
        expect(gameboard.grid).to be_kind_of(Array)
        expect(gameboard.grid.size).to eq(7)
      end
    end
  end

  describe '#put_piece places the corresponding player marker on the choosen column' do
    context 'when @player_one puts the first piece in the first column' do
      before { gameboard.put_piece("\e[31m\u26ab\e[0m", 1) }
      it 'falls on the first sub array with a red piece' do
        expect(gameboard.grid[0][0]).to eq("\e[31m\u26ab\e[0m")
      end
    end
  end

  describe '#show displays the board' do
    context 'when the board es empty' do
      xit 'prints the empty board' do
        expect(gameboard.show).to output(<<-GRID).to_stdout
           \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
           \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
           \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
           \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
           \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
           \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
        GRID
      end
    end    
  end
end
