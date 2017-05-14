module TicTacToe
  module Builds
    class Board < Array
      def initialize(size)
        @size = size
        make_tiles
      end

      private

      def make_tiles
        @size.times {self.push([])} # makes @size number of rows
        self.map! do |row|  # makes @size number of columns in each row
          @size.times {row.push(Tile.new)}
          row
        end
      end
    end

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
end
