require_relative "player"
require_relative "build"
require "pry"

module Game
  class Manager
    attr_reader :size, :player_one, :player_two, :board

    def initialize
      @size = welcome_to_game
      puts "size of board is #{@size}"
      build_board
      make_players
    end

    private
    def welcome_to_game
      puts "hi welcome to tic tac toe! \nhow big would you like your board to be?"
      gets.chomp.to_i
    end

    def make_players
      puts "what would you like to name the human?"
      name = gets.chomp
      human = Player::Human.new(name, "X")
      @player_one = human

      computer = Player::Computer.new("Computer", "O")
      @player_two = computer
    end

    def build_board
      @board = Build::Board.new(@size)
      @board.print_board
    end
  end
end

x = Game::Manager.new()
