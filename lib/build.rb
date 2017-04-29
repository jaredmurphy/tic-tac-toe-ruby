require "pry"

module Build
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
            @size.times { self.push([])} # makes @size number of columns
            self.map! do |row|  # makes @size number of rows in each column
                @size.times {row.push(Build::Tile.new)}
                row
            end
        end

        def printable_board
            board = self.map do |tile|
                tile.map {|row| row}.join(" | ")
            end
            board.join("\n")
        end
    end

    class Tile < String
        attr_accessor :value
        def initialize
            @value = 0
        end
        
        def update_value(string)
            @value = string == "X" ? 1 : -1
            self.concat(string)
        end
    end
end
