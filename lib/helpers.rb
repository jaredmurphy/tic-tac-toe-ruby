module Helpers
  def available_tiles(tiles)
    tiles.flatten.select{|tile| tile.value == nil}
  end
end
