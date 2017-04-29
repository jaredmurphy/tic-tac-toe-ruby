require "pry"

module Player
    class Player
        attr_reader :name, :symbol
        def initialize(name, symbol)
            @name = name
            @symbol = symbol
        end

        private

        def update_tile(tile, symbol)
            tile.value = symbol
        end

    end

    class Human < Player
        def play(board)
            puts "Hey #{@name} tell me the column you would like to play (1-#{board.length})"
            col= gets.chomp.to_i
            puts "Okay now the row (1-#{board.length})"
            row = gets.chomp.to_i
            update_tile(board[col - 1][row - 1], @symbol)

        end
    end

    class Computer < Player
        def play(board)
            puts "i am going to think of a spot to go"
            random_move(board)

        end

        private

        def random_move(tiles)
            choices = tiles.flatten.select{|tile| tile.value == nil}
            update_tile(choices.sample, @symbol)
        end
    end
end
