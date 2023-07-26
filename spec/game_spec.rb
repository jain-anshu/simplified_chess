require_relative '../game.rb'

RSpec.describe Game do
  describe '#has_won?' do  
    it 'returns false if other player has pieces_count > 0' do
        g = Game.new()
        expect(g.has_won?).to eq(false)
    end
  end
  describe '#within_boundary?' do
    it 'returns true if any of the parameters are not within board boundaries' do
        g = Game.new()
        i = 16
        j = 3
        expect(g.within_boundary?(i, j)).to eq(false)
    end
  end
end
