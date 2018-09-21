require 'game_board'

describe GameBoard do
  subject(:gameboard) { GameBoard.new() }

  describe '#set_up generates and empty board of 7 columns by 6 rows' do
    context 'when method is called it creates @board ' do
      before { gameboard.set_up }

      it 'is an Array' do
        expect(gameboard.board).to be_kind_of(Array)
      end

      it 'contains 6 sub arrays, one for each row' do
        expect(gameboard.board.size).to eq(6)
        expect(gameboard.board.all?(Array)).to be(true)
      end
    end
  end
end
