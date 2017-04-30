require_relative "game"

module GameMode
  class VsHuman < Game::Manager
    def initialize
      puts "vs human mode ready to go"
    end
  end

  class VsComputer < Game::Manager
    def initialize
      puts "vs computer mode ready to go"
    end
  end
end
