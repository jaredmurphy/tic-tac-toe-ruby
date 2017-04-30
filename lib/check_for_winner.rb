class CheckForWinner
      def check_for_winner
            check_for_horizontal
            check_for_vertical
            check_for_diagonal
      end
      private
      # the basic strategy of checking for the winner revolves around the value
      # property of the tile each tile has a value: 1 for 'X', 0 for blank tiles,
      # and -1 for 'O'

      # if the values in any row, column, or diagonal have an absolute total equal
      # to the size of the board, then we have a winner.

      # i reuse the check_rows function in the check for horizontal, vertical, and diagonal

      def check_for_horizontal # passes in the whole board array - rows
            check_rows(@board)
      end

      def check_for_vertical # passes in a 90 deg turned board - columns
            check_rows(@board.transpose)
      end

      def check_for_diagonal # passes the diagonals and reverse diagonals as a 2d array
            diagonal_range = (0..@board.length - 1)
            # credit to this post - http://stackoverflow.com/a/2506734/4859818
            diagonals = diagonal_range.collect {|i| @board[i][i]}
            reverse_diagonals = diagonal_range.collect{|i| @board[i][-i-1]}

            check_rows([diagonals, reverse_diagonals])
      end

      # check_rows takes a 2d array and gets the total of adding up all the tiles values from any row
      # if the total of the values adds up to the size of the board, we'll call update_winner
      def check_rows(board)
            tile_value = -> (tile){ tile.value }
            board.each do |row|
                  row_total = row.map(&tile_value).reduce(&:+)
                  update_winner(row_total) if row_total.abs == @size
            end
      end

      def update_winner(row_total)
            @winner = row_total == @size ? @player_one : @player_two
            @game_status = "#{@winner.name} wins!"
      end
end
