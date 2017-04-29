require "pry"
module Build
  class Board
    attr_accessor :tiles

    def initialize(size)
      @tiles = make_tiles(size)
      puts "tiles looks now like #{@tiles}"
    end

    def print_board
      puts "Current Board: \n#{printable_board}"
    end

    private

    def make_tiles(size)
      # borrrowed from http://stackoverflow.com/a/14696789/4859818
      # dynamically creates multi-dimensional array
      Array.new(size) {Array.new(size, Build::Tile.new)}
    end

    def printable_board
      board = @tiles.map do |tile|
        tile.map {|row| row.value}.join(" ")
      end
      board.join("\n")
    end
  end

  class Tile
    attr_accessor :value
    def initialize
      @value = random_value
    end

    private

    def random_value
      ["X", "O"].sample
    end
  end
end
