require "pry"
require_relative "helpers"
module Player
    class Player
        include Helpers # available_tiles method is from helpers

        attr_reader :name, :symbol
        def initialize(name, symbol)
            @name = name
            @symbol = symbol
        end
    end

    class Human < Player
        def play(board)
            selection = prompt_user(board)
            good_selection = available_tiles(board).include? selection
            while !good_selection do
                selection = prompt_user(board) {puts "Whoops! Looks like you made a bad selection. Try again!"}
                good_selection = available_tiles(board).include? selection
            end
            selection.update_value(@symbol)
        end

        private
        def prompt_user(board)
            yield if block_given?
            board[get_col - 1][get_row - 1]
        end

        def get_col
            puts "Hey #{@name} tell me the column you would like to play"
            gets.chomp.to_i
        end

        def get_row
            puts "Okay now the row"
            gets.chomp.to_i
        end
    end

    class Computer < Player
        def play(board)
            puts "i am going to think of a good tile to play now"
            random_move(board)
        end

        private
        def random_move(board)
            choices = available_tiles(board)
            choices.sample.update_value(@symbol)
        end
    end
end
