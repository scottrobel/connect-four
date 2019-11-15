# frozen_string_literal: true

require './lib/board.rb'
require 'pry'
describe Board do
  before(:each) do
    @player_one = double('player one', name: 'scott')
    @player_two = double('player two', name: 'jeff')
    @new_board = Board.new(5, @player_one, @player_two)
  end
  describe '#make_move' do
    it 'can make a move in an empty slot' do
      @new_board.make_move(5, 1)
      @new_board.make_move(1, 2)
      expect(@new_board.board_state[4][4]).to eql('♬')
      expect(@new_board.board_state[4][0]).to eql('⛴')
    end
    it 'can make a move in a slot with a piece in it' do
      3.times do
        @new_board.make_move(1, 1)
      end
      (2..4).each do |row|
        expect(@new_board.board_state[row][0]).to eql('♬')
      end
    end
  end

  describe '#slot_full?' do
    it 'returns true if slot is full' do
      5.times do
        expect(@new_board.slot_full?(1)).to eql(false)
        @new_board.make_move(1, 2)
      end
      expect(@new_board.slot_full?(1)).to eql(true)
    end
    it 'returns false if row if not full' do
      expect(@new_board.slot_full?(3)).to eql(false)
    end
  end
end
