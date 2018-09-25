require 'player'

describe Player do
  subject(:player) { Player.new('Pupe', 'red') }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:mark) }

  describe '#name shows player name' do
    context 'when Player name is Pupe' do
      it "returns 'Pupe'" do
        expect(player.name).to eq('Pupe')
      end
    end
  end

  describe '#mark represents the player piece ' do
    context 'when mark is a red circle' do
      it "returns \e[31m\u26ab\e[0m" do
        expect(player.mark).to eq("\e[31m\u26ab\e[0m")
      end
    end

    context 'when mark is a yellow circle' do
      let(:player) { Player.new('player', 'yellow') }
      it "returns \e[33m\u26ab\e[0m" do
        expect(player.mark).to eq("\e[33m\u26ab\e[0m")
      end
    end
  end
end
