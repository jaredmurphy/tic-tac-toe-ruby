require_relative "helpers"
require_relative "messenger"

module Player
    class Player
        include Helpers
        attr_reader :name, :symbol

        def initialize(name, symbol)
            @name = name
            @symbol = symbol
            @prompt = Messenger::Prompt.new
        end
    end

    class Human < Player
        def play(board)
            selection = pick_tiles(board)
            validate_availablility(selection, board)
            selection.update_value(@symbol)
        end

        private
        def pick_tiles(board)
            yield if block_given?
            row = @prompt.pick_tile(@name, board, "row")
            col = @prompt.pick_tile(@name, board, "column")
            board[row - 1][col - 1]
        end

        def validate_availablility(selection, board)
            good_selection = available_tiles(board).include? selection
            while !good_selection do
                selection = pick_tiles(board) {puts "Whoops! Looks like you made a bad selection. Try again!"}
                good_selection = available_tiles(board).include? selection
            end
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
