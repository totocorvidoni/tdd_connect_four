require 'game'

describe Game do
  subject(:game) { Game.new }

  describe '#new_player creates a player' do
    context "when 2 player" do
      before do
        game.new_player('Pupe')
        game.new_player('Toto')
      end

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

    describe '#board generates a new GameBoard object and assign it to @board' do
      it 'creates an empty board' do
        expect(game.board.grid).to be_kind_of(Array)
      end
    end
  end
end