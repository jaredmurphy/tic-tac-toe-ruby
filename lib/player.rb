require "pry"

module Player
    class Player
        attr_reader :name, :symbol
        def initialize(name, symbol)
            @name = name
            @symbol = symbol
        end
    end

    class Human < Player
        def move(x, y)
            puts "you chose #{x} and #{y}"
        end
    end

    class Computer < Player
        def move(board)
            puts "i am going to think of a spot to go"
        end
    end
end
