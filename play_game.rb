# frozen_string_literal: true

require './lib/board'
require './lib/user_interface'
require './lib/game'
require './lib/player'
new_game = Game.new
new_game.start_game
