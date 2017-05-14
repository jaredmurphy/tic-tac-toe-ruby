require_relative "builds"
require_relative "checks_for_winner"
require_relative "helpers"
require_relative "messenger"

module TicTacToe
  class GameMode
    include Helpers
    include Builds
    include ChecksForWinner

    def initialize
      @prompt = Messenger::Prompt.new
      @notice = Messenger::Notice.new

      set_up_game
    end

    private

    def set_up_game
      build_board
      set_up_players
      randomize_starter
      play_game
    end

    def build_board
      size = @prompt.board_size
      @board = Builds::Board.new(size)
    end

    def randomize_starter
      @current_turn = [@player_one, @player_two].sample
    end

    def play_game
      @notice.player_order
      while !@winner do
        @notice.current_turn(@current_turn.name)
        @notice.print_board(@board)
        @current_turn.play(@board)
        check_for_winner
        update_tie if !options_left?

        @current_turn = @current_turn == @player_one ? @player_two : @player_one
      end
      game_over
    end

    def game_over
      @notice.game_over(@game_status)
      @notice.print_board(@board)
      reset_game if play_again?
    end

    def update_tie
      @winner = "tie"
      @game_status = "Its a Tie!"
    end

    def options_left?
      choices = available_tiles(@board)
      choices.length > 0 ? true : false
    end

    def play_again?
      @prompt.play_again?
    end

    def reset_game
      Game.start
    end
  end
end
