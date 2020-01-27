# frozen_string_literal: true
require_relative 'game_manager'
require_relative 'board'

GameManager.new(ConnectFourBoard.new).play
