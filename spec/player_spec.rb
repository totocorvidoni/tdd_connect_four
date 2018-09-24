require 'player'

describe Player do
  subject(:player) { Player.new('Pupe', "\u26aa") }

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
    context 'when mark is an empty circle' do
      it "returns \u26aa" do
        expect(player.mark).to eq("\u26aa")
      end
    end

    context 'when mark is a circle' do
      let(:circle) { Player.new('circle', "\u26aa") }
      it "returns \u26ab" do
        expect(circle.mark).to eq("\u26aa")
      end
    end
  end
end
