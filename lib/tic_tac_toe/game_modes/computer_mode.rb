module TicTacToe
  class ComputerMode < GameMode
    private

    def set_up_players
      human_symbol = Builds::Tile.new
      computer_symbol = Builds::Tile.new

      human_symbol_val = @prompt.symbol_preference
      human_symbol.update_value(human_symbol_val)

      human_player_name = @prompt.player_name('human')

      computer_symbol_val = human_symbol == "X" ? "O" : "X"
      computer_symbol.update_value(computer_symbol_val)

      @player_one = Player::Human.new(human_player_name, human_symbol)
      @player_two = Player::Computer.new("Computer", computer_symbol)
    end
  end
end
