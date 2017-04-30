module Helpers
    def available_tiles(board)
        board.flatten.select{|tile| tile.blank?}
    end

    
end
