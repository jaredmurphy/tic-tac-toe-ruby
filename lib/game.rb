require_relative "player"
require_relative "build"
require "pry"

module Game
    class Manager
        include Helpers
        attr_reader :size, :board, :winner, :player_one, :player_two, :current_turn

        def initialize
            welcome_to_game
            make_players
            build_board
            @winner = nil
            @current_turn = randomize_starter
            play_game
        end

        private

        def randomize_starter
            [@player_one, @player_two].sample
        end

        def welcome_to_game
            puts "hi welcome to tic tac toe! \nhow big would you like your board to be?"
            @size = gets.chomp.to_i
            puts "size of board is #{@size}"
        end

        def make_players
            puts "what would you like to name the human?"
            @player_one = Player::Human.new(gets.chomp, "X")

            @player_two = Player::Computer.new("Computer", "O")
        end

        def build_board
            @board = Build::Board.new(@size)
        end

        def play_game
            while !@winner do
                @board.print_board
                @current_turn.play(@board)
                check_for_winner
                @current_turn = @current_turn == @player_one ? @player_two : @player_one
            end

            game_over
        end

        def options_left?
            choices = available_tiles(tiles)
            choices.length > 0 ? true : false
        end

        def check_for_winner
            check_horiztonal
        end

        def check_horiztonal
            row_total = 0
            @board.each do |row|
                row_total = row.reduce(0) {|prev, curr| prev += curr.value}

                if row_total == @size
                    @winner = @player_one
                elsif row_total == -@size
                    @winner = @player_two
                end

            end
        end

        def check_vertical
        end

        def check_diagonal
        end

        def game_over
            puts "game over"
        end
    end
end

x = Game::Manager.new()
