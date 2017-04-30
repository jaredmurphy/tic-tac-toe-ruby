require_relative "player"
require_relative "build"
require_relative "messenger"
require_relative "check_for_winner"
require_relative "hint"

module Game
    class Starter
        def initialize
            @notice = Messenger::Notice.new
            @prompt = Messenger::Prompt.new
            welcome_to_game
            @game_mode = game_mode
            start_game
        end

        def welcome_to_game
            @notice.welcome
        end

        def game_mode
            @game_mode = @prompt.game_mode
        end

        def start_game
            if @game_mode == "computer"
                VsComputerMode.new
            elsif @game_mode == "human"
                VsHumanMode.new
            elsif @game_mode == "hint"
                HintMode.new
            end
        end
    end # ends starter class

    class Manager < CheckForWinner
        include Helpers

        def initialize
            set_up_game
        end

        private

        def set_up_game
            @prompt = Messenger::Prompt.new
            @notice = Messenger::Notice.new
            build_board
            set_up_players
            randomize_starter
            play_game
        end

        def build_board
            @size = @prompt.board_size
            @board = Build::Board.new(@size)
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

        def update_tie
            @winner = "tie"
            @game_status = "Its a Tie!"
        end

        def options_left?
            choices = available_tiles(@board)
            choices.length > 0 ? true : false
        end

        def game_over
            @notice.game_over(@game_status)
            @notice.print_board(@board)
            reset_game if play_again?
        end

        def play_again?
            @prompt.play_again?
        end

        def reset_game
            Game::Starter.new
        end

    end #ends Manager class

    class VsHumanMode < Game::Manager
        private
        def set_up_players
            first_player_symbol = @prompt.symbol_preference
            first_player_name = @prompt.player_name('first')

            second_player_symbol = first_player_symbol == "X" ? "O" : "X"
            second_player_name = @prompt.player_name('second')

            @player_one = Player::Human.new(first_player_name, first_player_symbol)
            @player_two= Player::Human.new(second_player_name,second_player_symbol)

        end
    end

    class VsComputerMode < Game::Manager
        private
        def set_up_players
            human_symbol = Build::Tile.new
            computer_symbol = Build::Tile.new

            human_symbol_val = @prompt.symbol_preference
            human_symbol.update_value(human_symbol_val)

            human_player_name = @prompt.player_name('human')

            computer_symbol_val = human_symbol == "X" ? "O" : "X"
            computer_symbol.update_value(computer_symbol_val)

            @player_one = Player::Human.new(human_player_name, human_symbol)
            @player_two = Player::Computer.new("Computer", computer_symbol)

            # symbol = Build::Tile.new
            # chosen_symbol = symbol.update_value(@prompt.symbol_preference)
            # first_player_symbol = chosen_symbol
            #
            # another_symbol = Build::Tile.new
            # value = chosen_symbol == "X" ? "O" : "X"
            # assigned_symbol = another_symbol.update_value(value)
            # second_player_symbol = assigned_symbol
            #
            # first_player_name = @prompt.player_name('first')
            # second_player_name = @prompt.player_name('second')
            #
            # @player_one = Player::Human.new(first_player_name, chosen_symbol)
            # @player_two= Player::Human.new(second_player_name, assigned_symbol)
        end
    end

    class HintMode < VsComputerMode
        def initialize
            @hint = Hint.new
            set_up_game
        end

        private
        # overwrites play_game from Manager, so that only humans will get hints
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
            #puts "opponent #{opponent}"
            @hint.get_hint(@board, @current_turn.symbol, opponent.symbol) unless @current_turn.name == "Computer"
        end

    end
    #
    # class IntelligentMode < GameManager
    # end

end # ends Game module

Game::Starter.new
