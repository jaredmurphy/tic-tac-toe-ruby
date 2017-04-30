module Messenger
  class Prompt
    def response_correction(correction)
      "Woops! Please type in only - #{correction}"
    end

    def game_mode
      puts "Which game mode would you like to play? - say 'computer', 'hint' or 'human'"
      puts "Hint Mode is only vs the computer"
      yield if block_given?
      response = gets.chomp
      game_mode {response_correction("'computer' or 'human'")} unless response == "computer" || response == "human" || response == "hint"
      response
    end

    def board_size
      puts "How big should this board be?"
      puts "Say 3 for 3x3, or 5 for 5x5. You get the picture"
      yield if block_given?
      response = gets.chomp.to_i
      board_size {response_correction("odd numbers")} unless response % 2 != 0
      response
    end

    def symbol_preference
      puts "Would you rather be X or O? Specify 'X' or 'O'"
      yield if block_given?
      response = gets.chomp.upcase
      symbol_preference { response_correction("'X' or 'O'")} unless response == "X" || response == "O"
      response
    end

    def player_name(type)
        puts "What is the #{type} player's name?"
        gets.chomp
    end

    def play_again?
        puts "Would you like to play again? - y or n"
        yield if block_given?
        response = gets.chomp.downcase
        if response == "y"
            return true
        elsif response == "n"
            return false
        else
            play_again? { response_correction("'y' or 'n'")}
        end
    end

    def pick_tile(name, board, row_or_col)
        puts "Hey #{name} tell me the #{row_or_col} you would like to play"
        response = gets.chomp.to_i
        if response > board.length || response < 0
            pick_tile { response_correction("'Please choose a valid space on the board'")}
        end
        response
    end

  end

  class Notice
    def welcome
      puts "hi welcome to tic tac toe!"
    end

    def mode_confirmation(type)
      puts "Okay, this will be a human vs #{type} game"
    end

    def game_over(game_status)
        puts "Game Over #{game_status}"
    end

    def print_board(board)
        puts "Current Board: \n#{printable_board(board)}"
    end

    def current_turn(player_name)
        puts "It is #{player_name}'s turn"
    end

    def player_order

    end

    private
    def printable_board(board)
        # board_lines makes the lines between each position on the board
        board_lines = board.map do |tile|
            tile.map {|row| row }.join(" | ")
        end.join("\n")
        #guide makes column numbers at the top of the board for reference
        guide = (0..board.length - 1).collect {|i| "#{i + 1}   "}.join("")
        "#{guide}\n#{board_lines}"
    end
  end

  class Hint
    def block_hint(hint_hash)
      type, value = hint_hash.first
      puts "HINT!\nYou should always block your opponent!\nGo ahead, block their next #{type} move!"
    end
    
    def win_hint(hint_hash)
      type, value = hint_hash.first
      puts "HINT!\nYou should always play the winning move if you can!\nGo ahread, you've got a #{type} move open right now!"
    end
  end
end
