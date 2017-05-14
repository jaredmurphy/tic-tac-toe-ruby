module TicTacToe
  module ChecksForWinner
    def check_for_winner
      check_for_horizontal
      check_for_vertical
      check_for_diagonal
    end

    private
    # the basic strategy of checking for the winner revolves around the value
    # property of the tile each tile has a value: 1 for 'X', 0 for blank tiles,
    # and -1 for 'O'

    # if the values in any row, column, or diagonal have an absolute total
    # equal to the size of the board, then we have a winner.

    # We reuse the check_rows function in the check for
    # horizontal, vertical, and diagonal

    # Pass in the whole board array: rows
    def check_for_horizontal(player = nil)
      check_rows(@board, player)
    end

    # Pass in a 90 deg turned board: columns
    def check_for_vertical(player = nil)
      check_rows(@board.transpose, player)
    end

    # Pass the diagonals and reverse diagonals as a 2d array
    def check_for_diagonal(player = nil)
      diagonal_range = (0..@board.length - 1)
      # credit to this post for getting diags
      # http://stackoverflow.com/a/2506734/4859818
      diagonals = diagonal_range.collect {|i| @board[i][i]}
      reverse_diagonals = diagonal_range.collect{|i| @board[i][-i-1]}

      check_rows([diagonals, reverse_diagonals], player)
    end

    # check_rows takes a 2d array and gets the total of adding up all the
    # tiles values from any row
    # if the total of the values adds up to the size of the
    # board, we'll call update_winner
    # when using this algorithm for a hint, we will just return the rows
    # that are 1 play away from a win
    def check_rows(board, player = nil)
      tile_value = -> (tile){tile.value}
      if player # ie - if we are looking for a hint, not a winner
        board.select do |row|
          row_total = row.map(&tile_value).reduce(&:+).abs
          row_length_minus_one = (row.length) - 1
          # we should only deal with the rows that have a total of size -1
          # but we want to avoid for example [X, O, X] so check to make sure one of them is blank
          # also make sure that the 1 offs are for the correct player
          row if (row_total == row_length_minus_one && row.include?(" ") && row.include?(player))
        end
      else # if we are looking for a winner
        board.each do |row|
          row_total = row.map(&tile_value).reduce(&:+).abs
          update_winner(row_total) if row_total == row.length
        end
      end
    end

    def update_winner(row_total)
      @winner = row_total == @size ? @player_one : @player_two
      @game_status = "#{@winner.name} wins!"
    end
  end
end
