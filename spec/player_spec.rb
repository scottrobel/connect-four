# frozen_string_literal: true

require './lib/player.rb'
describe Player do
  before(:each) do
    @new_player = Player.new('Scott')
  end

  describe '#initialize' do
    it 'assigns names' do
      expect(@new_player.name).to eq('Scott')
    end
  end
end
