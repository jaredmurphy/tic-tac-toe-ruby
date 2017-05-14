require 'spec_helper'
require_relative '../lib/tic_tac_toe/messenger'

describe Messenger::Prompt do
  describe "#game_mode" do
    input = ["human", "computer"].sample
    before do
      $stdin = StringIO.new(input)
    end

    it "returns a correct game mode response from the user" do
      expect(Messenger::Prompt.new.select_game_mode).to eq(input.to_sym)
    end
  end

  describe "#response_correction" do
    it "formats a response string with input" do
      input = "'y' or 'n'"
      expected_response = "Woops! Please type in only: #{input}"
      expect(Messenger::Prompt.new.response_correction(input)).to eq(expected_response)
    end
  end

  describe "#board_size" do
    input = ["3", "5"].sample
    before do
      $stdin = StringIO.new(input)
    end
    it "returns a correct board size response from the user" do
      expect(Messenger::Prompt.new.board_size).to eq(input.to_i)
    end
  end
end

describe Messenger::Notice do
  describe "#welcome" do
    it "prints a welcome message for the user" do
      expect do
        Messenger::Notice.new.welcome
      end.to output("hi welcome to tic tac toe!\n").to_stdout
    end
  end
  describe "#mode_confirmation" do
    it "confirms the game mode to the user" do
      type = ["human", "computer"].sample
      expect do
        Messenger::Notice.new.mode_confirmation(type)
      end.to output("Okay, this will be a human vs #{type} game\n").to_stdout
    end
  end
end
