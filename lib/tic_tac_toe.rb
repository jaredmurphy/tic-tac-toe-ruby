
require_relative "tic_tac_toe/exceptions"
require_relative "tic_tac_toe/game"
require_relative "tic_tac_toe/game_mode"
require_relative "tic_tac_toe/hint"
require_relative "tic_tac_toe/player"

require_relative "tic_tac_toe/checks_for_winner"

require_relative "tic_tac_toe/game_modes/computer_mode"
require_relative "tic_tac_toe/game_modes/hint_mode"
require_relative "tic_tac_toe/game_modes/human_mode"

module TicTacToe
end

TicTacToe::Game.start
