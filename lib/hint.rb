require_relative "check_for_winner"
require_relative "messenger"

class Hint < CheckForWinner
  include Helpers
  include Messenger

  def initialize
    @hint_talk = Messenger::Hint.new
  end

  def get_hint(board, player, opponent)
    @board = board
    #get hints
    block_opponent = check_one_move_away_from_win(opponent)
    win_this_turn = check_one_move_away_from_win(player)
    # no empty hints
    block_opponent.select! {|key| !block_opponent[key].empty?}
    win_this_turn.select! {|key| !win_this_turn[key].empty?}
    # let messenger figure out what to say
    @hint_talk.block_hint(block_opponent) if !block_opponent.empty?
    @hint_talk.win_hint(win_this_turn) if !win_this_turn.empty?
  end

  private
  def check_one_move_away_from_win(player)
    horizontal = check_for_horizontal(player)
    vertical = check_for_vertical(player)
    diagonal = check_for_diagonal(player)
    {horizontal: horizontal, vertical: vertical, diagonal: diagonal}
  end
end
