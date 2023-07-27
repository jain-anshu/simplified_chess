# frozen_string_literal: true

require_relative '../game'

RSpec.describe Game do
  before do
    # Q : why is this executing for both the specs below
    @g = Game.new
  end

  # describe '#has_won?' do
  it '#has_won? false if other player has pieces_count > 0' do
    expect(@g.has_won?).to eq(false)
  end
  # end
  # describe '#within_boundary?' do
  it '#within_boundary? returns false if any of the parameters are not within board boundaries' do
    # g = Game.new()
    i = 16
    j = 3
    expect(@g.within_boundary?(i, j)).to eq(false)
  end

  it '#within_boundary? returns true if both the parameters are within board boundaries' do
    # g = Game.new()
    i = 0
    j = 5
    expect(@g.within_boundary?(i, j)).to eq(true)
  end
  # end
end
