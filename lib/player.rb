module Player
    class Player
    end

    class Human < Player
        attr_reader :name, :symbol

        def initialize(name, symbol)
            @name = name
            @symbol = symbol
        end

        def move(x, y)
            puts "you chose #{x} and #{y}"
        end
    end
end
