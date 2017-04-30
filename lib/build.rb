require "pry"

module Build
    # use of polymorphism
    class Board < Array
        def initialize(size)
            @size = size
            make_tiles
        end

        def print_board
            puts "Current Board: \n#{printable_board}"
        end

        private

        def make_tiles
            @size.times {self.push([])} # makes @size number of rows
            self.map! do |row|  # makes @size number of columns in each row
                @size.times {row.push(Build::Tile.new)}
                row
            end
        end

        def printable_board
            # board_lines makes the lines between each position on the board
            board_lines = self.map do |tile|
                tile.map {|row| row }.join(" | ")
            end.join("\n")
            #guide makes column numbers at the top of the board for reference
            guide = (0..@size - 1).collect {|i| "#{i + 1}   "}.join("")
            "#{guide}\n#{board_lines}"
        end
    end


    # use of polymorphism
    class Tile < String
        attr_accessor :value
        def initialize
            @value = 0
            self.replace(" ")
        end

        def blank? # called in Helper:available_tiles
            self.match(/\s/) ? true : false
        end

        def update_value(symbol)
            @value = symbol == "X" ? 1 : -1
            self.replace(symbol)
        end
    end
end
