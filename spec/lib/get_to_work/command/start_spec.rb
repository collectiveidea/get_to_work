require "spec_helper"

describe GetToWork::Command::Start do
  describe "#parse_pt_id" do
    let(:start) { GetToWork::Command::Start.new }

    it "parses the correct pivotal tracker id" do
      with_number = "12345"
      expect(start.parse_pt_id(with_number)).to eql("12345")

      with_id = "#12345"
      expect(start.parse_pt_id(with_id)).to eql("12345")

      with_url = "https://www.pivotaltracker.com/story/show/112921213"
      expect(start.parse_pt_id(with_url)).to eql("112921213")
    end
  end
end
