require_relative "player"
require "pry"

class Game
  attr_reader :size, :player_one, :player_two

  def initialize
    @size = welcome_to_game
    puts "size of board is #{@size}"
    make_players
  end

  private
  def welcome_to_game
    puts "hi welcome to tic tac toe!"
    puts "how big would you like your board to be?"
    gets.chomp
  end

  def make_players
    puts "what would you like to name the human?"
    name = gets.chomp
    x = Player::Human.new(name, "X")
    @player_one = x
    puts x
  end
end

x = Game.new()
