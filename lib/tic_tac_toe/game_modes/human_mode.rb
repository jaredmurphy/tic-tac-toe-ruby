module TicTacToe
  class HumanMode < GameMode
    private

    def set_up_players
      first_player_symbol = @prompt.symbol_preference
      first_player_name = @prompt.player_name("first")

      second_player_symbol = first_player_symbol == "X" ? "O" : "X"
      second_player_name = @prompt.player_name('second')

      @player_one = Human.new(first_player_name, first_player_symbol)
      @player_two= Human.new(second_player_name, second_player_symbol)
    end
  end
end
