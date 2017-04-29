module Helpers
    def available_tiles(tiles)
        tiles.flatten.select{|tile| tile.empty?}
    end
end
