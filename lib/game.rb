# frozen_string_literal: true

#  this class is the method that the game is played out
class Game
  include UserInterface
  def initialize
    @player_one_char = '♬'
    @player_two_char = '⛴'
  end

  def start_game
    create_board_from_input
    player_one_turn = true
    until win?(1) || win?(2)
      name, number = player_info(player_one_turn)
      slot = get_slot_from_user(name, number, @board)
      make_move(slot, number)
      player_one_turn = !player_one_turn
    end
    award_winner
  end

  private

  def player_info(player_one_turn)
    if player_one_turn
      [@board.player_one_name, 1]
    else
      [@board.player_two_name, 2]
    end
  end

  def create_board_from_input
    player_one = make_player(1)
    player_two = make_player(2)
    @board = Board.new(20, player_one, player_two)
  end

  def make_move(slot, player_number)
    @board.make_move(slot, player_number)
  end

  def win?(player_number)
    %w[horizontal vertical diagonal].any? do |search_type|
      method("#{search_type}_win?".to_sym).call(player_number)
    end
  end

  def horizontal_win?(player_number)
    char = player_number == 1 ? @player_one_char : @player_two_char
    @board.board_state.transpose.any? do |coulmn|
      coulmn.join.match?(/#{char}{4}/)
    end
  end

  def vertical_win?(player_number)
    char = player_number == 1 ? @player_one_char : @player_two_char
    @board.board_state.any? do |coulmn|
      coulmn.join.match?(/#{char}{4}/)
    end
  end

  def diagonal_win?(player_number)
    char = player_number == 1 ? @player_one_char : @player_two_char
    board = @board.board_state
    diagonal_rows = create_diagonal_rows(board)
    oppisite_diagonal_rows = create_diagonal_rows(board.map(&:reverse))
    match = ->(row) { row.join.match?(/#{char}{4}/) }
    diagonal_rows.any?(&match) || oppisite_diagonal_rows.any?(&match)
  end

  def create_diagonal_rows(game_board)
    board = Marshal.load(Marshal.dump(game_board))
    diagonal_rows = []
    queued_rows = [[[0, 0]]]
    until queued_rows.empty?
      row_positions = queued_rows.shift
      row, next_row = traverse_one_row(row_positions, board)
      queued_rows << next_row unless next_row.empty?
      diagonal_rows << row
    end
    diagonal_rows
  end

  def traverse_one_row(row_positions, board)
    row = []
    next_row = []
    until row_positions.empty?
      position = row_positions.shift
      row << board[position[0]][position[1]]
      next_row.concat(neighbor_positions(position, next_row))
    end
    [row, next_row]
  end

  def neighbor_positions(position, next_row)
    neighbors = []
    right = [position[0], position[1] + 1]
    neighbors << right if add_position?(next_row, right)
    bottom = [position[0] + 1, position[1]]
    neighbors << bottom if add_position?(next_row, bottom)
    neighbors
  end

  def add_position?(row_positions, position)
    !row_positions.include?(position) && on_board?(position)
  end

  def on_board?(position)
    board_size = @board.size - 1
    position[0] <= board_size && position[1] <= board_size
  end
end
