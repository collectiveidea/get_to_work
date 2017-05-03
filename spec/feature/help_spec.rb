require "spec_helper"

RSpec.describe "get-to-work help", type: :aruba do
  it "prints the usage" do
    run "exe/get-to-work help"
    stop_all_commands

    usages = [
      /get-to-work bootstrap/,
      /get-to-work help \[COMMAND\]/,
      /get-to-work last_story/,
      /get-to-work start/,
      /get-to-work stop/,
    ]

    usages.each do |usage|
      expect(last_command_started.output)
        .to match(usage)
    end
  end
end
