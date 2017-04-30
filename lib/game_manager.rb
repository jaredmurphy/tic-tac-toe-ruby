require_relative "player"
require_relative "build"
require "pry"


class GameManager
    include Helpers

    def initialize
        set_up_game
    end

    private

    def set_up_game
        welcome_to_game
        make_players
        @current_turn = randomize_starter
        @winner = nil
        build_board
        play_game
    end

    def welcome_to_game
        puts "hi welcome to tic tac toe!"
        @size = prompt_user

        puts "size of board is #{@size} by #{@size}"
    end

    # point out use of recursion
    def prompt_user
        yield if block_given?
        puts "how big would you like your board to be?\nSay 3 for 3x3, or 5 for 5x5.\nYou get the picture"
        response = gets.chomp.to_i
        prompt_user { puts "WOOOPS! We can only do even numbers!" } if response % 2 == 0
        response
    end

    def make_players
        puts "what would you like to name the human?"
        name = gets.chomp
        puts "whould you like to be X or O?"
        symbol = gets.chomp.upcase
        computer_symbol = symbol == "X" ? "O" : "X"

        @player_one = Player::Human.new(name, symbol)
        @player_two = Player::Computer.new("Computer", computer_symbol)
    end

    def build_board
        @board = Build::Board.new(@size)
    end

    def randomize_starter
        [@player_one, @player_two].sample
    end

    def play_game
        while !@winner do
            @board.print_board
            @current_turn.play(@board)
            check_for_horizontal
            check_for_vertical
            check_for_diagonal

            @current_turn = @current_turn == @player_one ? @player_two : @player_one
        end

        game_over
    end

    ###
    ### Check for winner
    ###

    # the basic strategy of checking for the winner revolves around the value
    # property of the tile each tile has a value: 1 for 'X', 0 for blank tiles,
    # and -1 for 'O'

    # if the values in any row, column, or diagonal have an absolute total equal
    # to the size of the board, then we have a winner.

    # i reuse the check_rows function in the check for horizontal, vertical, and diagonal


    def check_for_horizontal # passes in the whole board array - rows
        check_rows(@board)
    end

    def check_for_vertical # passes in a 90 deg turned board - columns
        check_rows(@board.transpose)
    end


    def check_for_diagonal # passes the diagonals and reverse diagonals as a 2d array
        diagonal_range = (0..@board.length - 1)
        # borrowed this post - http://stackoverflow.com/a/2506734/4859818
        diagonals = diagonal_range.collect {|i| @board[i][i]}
        reverse_diagonals = diagonal_range.collect{|i| @board[i][-i-1]}

        check_rows([diagonals, reverse_diagonals])
    end

    # takes a 2d array and gets the total of adding up all the tiles values from any row
    # if the total of the values adds up to the size of the board, we'll call update_winner
    # mention use of stabby lambda
    def check_rows(board)
        tile_value = -> (tile){ tile.value }
        board.each do |row|
            row_total = row.map(&tile_value).reduce(&:+)
            update_winner(row_total) if row_total.abs == @size
        end
    end

    def update_winner(row_total)
        @winner = row_total == @size ? @player_one : @player_two
        @game_status = "#{@winner.name} wins!"
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
        puts "Game Over #{@game_status}"
        @board.print_board
        reset_game if play_again?
    end

    def play_again?
        puts "Would you like to play again? - y or n"
        yield if block_given?
        response = gets.chomp.downcase

        if response == "y"
            true
        elsif response == "n"
            false
        else
            play_again? { puts "Please type 'y' or 'n'"}
        end
    end

    def reset_game
        @game_status = nil
        set_up_game
    end

end

GameManager.new()
