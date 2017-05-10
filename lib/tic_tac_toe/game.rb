module TicTacToe
  class Game
    class << self
      def start
        notice = Messenger::Notice.new
        prompt = Messenger::Prompt.new

        notice.welcome
        self.select_game_mode(prompt.select_game_mode)
      end
    end

    private

    def self.select_game_mode(choice)
      case choice
      when :computer
        ComputerMode.new
      when :human
        HumanMode.new
      when :hint
        HintMode.new
      else
        raise TicTacToe::InvalidGameMode.new
      end
    end
  end
end
