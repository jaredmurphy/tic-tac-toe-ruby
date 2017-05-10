module TicTacToe
  class HintMode < ComputerMode
    def initialize
      @hint = Hint.new
      super
    end

    private

    def play_game
      @notice.player_order
      while !@winner do
        @notice.current_turn(@current_turn.name)
        @notice.print_board(@board)
        get_hint_if_human
        @current_turn.play(@board)
        check_for_winner
        update_tie if !options_left?

        @current_turn = @current_turn == @player_one ? @player_two : @player_one
      end
      game_over
    end

    def get_hint_if_human
      # as long as the current player is not the computer, get a hint
      opponent = @player_one == @current_turn ? @player_two : @player_one
      @hint.get_hint(@board, @current_turn.symbol, opponent.symbol) unless @current_turn.name == "Computer"
    end
  end
end
