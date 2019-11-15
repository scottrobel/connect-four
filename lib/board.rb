# frozen_string_literal: true

require 'pry'
# contains the players and the board state
class Board
  attr_reader :board_state, :size, :player_one_name, :player_two_name
  def initialize(size, player_one, player_two)
    @size = size
    @filler_char = '⚬'
    @board_state = Array.new(size) { Array.new(size) { @filler_char } }
    @player_one = player_one
    @player_two = player_two
    @player_one_name = @player_one.name
    @player_two_name = @player_two.name
    @player_two = player_two
  end

  def to_s
    selection = ''
    (1..@size).each do |number|
      selection += number.to_s.ljust(3)
    end
    selection += "\n"
    board = board_state.map do |row|
      "#{row.join("\s\s")}\n\n"
    end
    selection + board.join + selection
  end

  def make_move(column, player_number)
    column = column.to_i - 1
    row = move_row(column)
    char = player_number == 1 ? '♬' : '⛴'
    @board_state[row][column] = char
  end

  def slot_full?(slot)
    @board_state[0][slot - 1] == '♬' || @board_state[0][slot - 1] == '⛴'
  end

  private

  def move_row(column)
    @board_state.transpose[column].join.match(/⚬+/)[0].length - 1
  end
end
