require 'game_board'

describe GameBoard do
  subject(:gameboard) { GameBoard.new }

  describe '#grid stores the board state' do
    context 'when object is created' do
      it 'is an array with 7 empty subarrays' do
        expect(gameboard.grid).to be_kind_of(Array)
        expect(gameboard.grid.size).to eq(7)
      end
    end
  end

  describe '#show displays the board' do
    context 'when the board es empty' do
      it 'prints the empty board' do
        # \u0020 = SPACE, placed before each line beacuse <<~ erases all white spaces
        expect { gameboard.show }.to output(<<~GRID).to_stdout
        \u0020\u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
        \u0020\u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
        \u0020\u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
        \u0020\u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
        \u0020\u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
        \u0020\u26aa \u26aa \u26aa \u26aa \u26aa \u26aa \u26aa
        \u0020\e[32m\u24f5\e[0m \e[32m\u24f6\e[0m \e[32m\u24f7\e[0m \e[32m\u24f8\e[0m \e[32m\u24f9\e[0m \e[32m\u24fa\e[0m \e[32m\u24fb\e[0m
        GRID
      end
    end    
  end

  describe '#put_piece places the corresponding player marker on the choosen column' do
    context 'when a red marker is put in the first column' do
      before { gameboard.put_piece("\e[31m\u26ab\e[0m", 0) }
      it 'falls on the first subarray with a red piece' do
        expect(gameboard.grid[0][0]).to eq("\e[31m\u26ab\e[0m")
      end
    end    
  end
end
