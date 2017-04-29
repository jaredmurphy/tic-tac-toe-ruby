require "pry"

module Build

  class Board
    attr_accessor :tiles

    def initialize size
      @tiles = make_tiles size
    end

    def print_board
      puts "Current Board: \n#{printable_board}"
    end

    private

    def make_tiles(size)
      # borrrowed from http://stackoverflow.com/a/14696789/4859818
      # dynamically creates multi-dimensional array
      # bug - uses the same object for tile.new
      #Array.new(size) {Array.new(size, Build::Tile.new)}


      board = []
      size.times {board.push([])}
      board.map! do |row|
        size.times {row.push(Build::Tile.new)}
        row
      end
    end

    def printable_board
      board = @tiles.map do |tile|
        tile.map {|row| row.value}.join(" | ")
      end
      board.join("\n")
    end
  end

  class Tile
    attr_accessor :value
    def initialize
      @value = nil
    end
  end
end
