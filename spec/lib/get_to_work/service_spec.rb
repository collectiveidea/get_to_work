require "spec_helper"

class MyService < GetToWork::Service
  display_name "My Service"
  attr_reader :foo
end

describe GetToWork::Service do
  subject { MyService.new }

  it do
    is_expected.to have_attributes(
      name: "MyService",
      display_name: "My Service",
      yaml_key: "my_service"
    )
  end

  describe "#new" do
    let(:configs) do
      { "service" => { "foo_bar_id" => 1, "baz_id" => 3 } }
    end

    subject { GetToWork::Service.new(configs) }

    it "creates instance variables from configuration data" do
      expect(subject).to have_attributes(
        foo_bar_id: 1,
        baz_id: 3
      )
    end
  end
end
