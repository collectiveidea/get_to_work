require "spec_helper"

class MyService < GetToWork::Service
  display_name "My Service"
  attr_reader :foo
end

describe GetToWork::Service do
  let(:service) { MyService.new }

  describe "#display_name" do
    it "returns a name to be displayed for the service" do
      expect(service.display_name).to eq("My Service")
    end
  end

  describe "#name" do
    it "returns the name of the class" do
      expect(service.name).to eq("MyService")
    end
  end

  describe "#yaml_key" do
    it "returns the yaml key to use for configuration" do
      expect(service.yaml_key).to eq("my_service")
    end
  end

  it "loads configuration information given a yaml node" do
    data = {
      "other_service" => {
        "foo" => "bar"
      },
      "my_service" => {
        "foo" => "baz"
      }
    }

    subject = MyService.new(data)
    expect(subject.foo).to eql("baz")
  end
end
