require_relative "helpers"
require_relative "check_for_winner"
require "pry"
require_relative "build"
require_relative "messenger"

class Hint < CheckForWinner
  include Helpers
  include Messenger

  def initialize
    @hint_talk = Messenger::Hint.new
  end

  def get_hint(board, player, opponent)
    @board = board
    #binding.pry
    #getting hints
    block_opponent = check_one_move_away_from_win(opponent)
    win_this_turn = check_one_move_away_from_win(player)
    # no empty hints
    block_opponent.select! {|key| !block_opponent[key].empty?}
    win_this_turn.select! {|key| !win_this_turn[key].empty?}
    # let messenger figure out what to say
    # if !block_opponent.empty?
    #   binding.pry
    # end
    @hint_talk.block_hint(block_opponent) if !block_opponent.empty?
    @hint_talk.win_hint(win_this_turn) if !win_this_turn.empty?

    # if block_opponent.empty? && win_this_turn.empty?
    #   available_corners = check_for_corners(board)
    #   @hint_talk.corners_hint(available_corners)
    # end
  end

  private

  def check_one_move_away_from_win(player)
    horizontal = check_for_horizontal(player)
    vertical = check_for_vertical(player)
    diagonal = check_for_diagonal(player)
    #binding.pry
    #{diagonal: diagonal}
    {horizontal: horizontal, vertical: vertical, diagonal: diagonal}
  end

  # def check_for_corners(board)
  #   corners = [
  #     board[0][0],
  #     board[0][-1],
  #     board[-1][0],
  #     board[-1][-1]
  #   ]
  #   available_tiles(corners).sample
  # end

end

# hint = Hint.new
# p_one = Build::Tile.new
# p_two = Build::Tile.new
# blank = Build::Tile.new
# p_one.update_value("X")
# p_two.update_value("O")
#
# board = [
#   [p_one, p_one, blank],
#   [blank, p_two, p_two],
#   [p_two, blank, p_two]
# ]
# hint.get_hint(board, p_one, p_two)
