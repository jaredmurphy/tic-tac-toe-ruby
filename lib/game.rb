require_relative "player"
require_relative "build"
require_relative "messenger"
require_relative "check_for_winner"

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
            end
        end
    end # ends starter class

    class Manager < CheckForWinner
        include Helpers
        
        def initialize
            @prompt = Messenger::Prompt.new
            @notice = Messenger::Notice.new
            build_board
            set_up_players
            randomize_starter
            play_game
        end

        private

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
                @notice.print_board(@board)
                @current_turn.play(@board)
                check_for_winner

                @current_turn = @current_turn == @player_one ? @player_two : @player_one
            end
            game_over
        end

        def update_tie
            @winner = "tie"
            @game_status = "Its a Tie!"
        end
        # use of module mixin
        def options_left?
            choices = available_tiles(tiles)
            choices.length > 0 ? true : false
        end

        ###
        ### end of game
        ###

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
            human_player_symbol = @prompt.symbol_preference
            human_player_name = @prompt.player_name('human')

            computer_player_symbol = human_player_symbol == "X" ? "O" : "X"

            @player_one = Player::Human.new(human_player_name, human_player_symbol)
            @player_two = Player::Computer.new("Computer", computer_player_symbol)
        end
    end

end # ends Game module


Game::Starter.new

#
# class HintMode < GameManager
# end
#
# class IntelligentMode < GameManager
# end
