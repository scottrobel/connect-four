# frozen_string_literal: true

require './lib/user_interface'
require './lib/game.rb'
describe Game do
  before(:each) do
    @new_game = Game.new
    allow(@new_game).to receive(:gets).and_return('scott')
    allow(@new_game).to receive(:print).and_return(nil)
    allow(@new_game).to receive(:puts).and_return(nil)
    @player = @new_game.make_player(2)
  end
  describe '#make_player' do
    it 'sets the player name' do
      expect(@player.name).to eql('scott')
    end
  end

  describe '#create_board' do
    it 'creates a board with players with no user mistakes' do
      allow(@new_game).to receive(:gets).and_return('scott', 'jeff')
      board = @new_game.create_board_from_input
      expect(board.player_one_name).to eql('scott')
    end
    it 'creates a board with user mistakes' do
      allow(@new_game).to receive(:gets).and_return('Scott', "\n", 'jeff')
      board = @new_game.create_board_from_input
      expect(board.player_one_name).to eql('Scott')
    end
  end

  describe '#win?' do
    before(:each) do
      allow(@new_game).to receive(:gets).and_return('scott', 'jeff')
      @new_game.create_board_from_input
    end
    it 'returns true if there are 4 in a row verticly' do
      4.times do |slot|
        @new_game.send(:make_move, slot + 1, 1)
      end
      expect(@new_game.send(:win?, 1)).to eql(true)
    end
    it 'returns true if there are 4 in a row horizontaly' do
      4.times do
        @new_game.send(:make_move, 2, 1)
      end
      expect(@new_game.send(:win?, 1)).to eql(true)
    end
    it 'returns true if 4 in a row diagonally' do
      4.times do |moves_per_row|
        moves_per_row.times do
          row = moves_per_row + 1
          @new_game.send(:make_move, row, 1)
        end
      end
      (1..4).each do |row|
        @new_game.send(:make_move, row, 2)
      end
      expect(@new_game.send(:diagonal_win?, 2)).to eql(true)
      expect(@new_game.send(:diagonal_win?, 1)).to eql(false)
    end
    it 'doesnt alwase return true' do
      expect(@new_game.send(:win?, 2)).to eql(false)
      expect(@new_game.send(:win?, 1)).to eql(false)
    end
  end
  describe '#diagonal_win?' do
    before(:each) do
      allow(@new_game).to receive(:gets).and_return('scott', 'jeff')
      @new_game.create_board_from_input
    end
    it 'returns true if you have 4 in a row diagonally' do
      4.times do |moves_per_row|
        moves_per_row.times do
          row = moves_per_row + 1
          @new_game.send(:make_move, row, 1)
        end
      end
      (1..4).each do |row|
        @new_game.send(:make_move, row, 2)
      end
      expect(@new_game.send(:diagonal_win?, 2)).to eql(true)
      expect(@new_game.send(:diagonal_win?, 1)).to eql(false)
    end
    it 'doesnt always return true' do
      expect(@new_game.send(:diagonal_win?, 2)).to eql(false)
      expect(@new_game.send(:diagonal_win?, 1)).to eql(false)
    end
  end
  describe 'vertical_win?' do
    before(:each) do
      allow(@new_game).to receive(:gets).and_return('scott', 'jeff')
      @new_game.create_board_from_input
    end
    it 'returns true if there is 4 in a row vertically' do
      (1..4).each do |slot|
        @new_game.send(:make_move, slot, 1)
      end
      expect(@new_game.send(:vertical_win?, 1)).to eql(true)
    end
    it 'does not always return true' do
      expect(@new_game.send(:vertical_win?, 1)).to eql(false)
      expect(@new_game.send(:vertical_win?, 2)).to eql(false)
    end
  end
  describe '#horizontal_win?' do
    before(:each) do
      allow(@new_game).to receive(:gets).and_return('scott', 'jeff')
      @new_game.create_board_from_input
    end
    it 'returns true if 4 in a row horizontally' do
      4.times do
        expect(@new_game.send(:horizontal_win?, 1)).to eql(false)
        @new_game.send(:make_move, 2, 1)
      end
      expect(@new_game.send(:horizontal_win?, 1)).to eql(true)
    end
    it 'does not always return true' do
      expect(@new_game.send(:horizontal_win?, 1)).to eql(false)
    end
  end
end
describe '#start_game' do
  it 'plays out a game' do
    game = Game.new
    game.start_game
  end
end
