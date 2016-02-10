require "spec_helper"

class MyService < GetToWork::Service
  attr_reader :foo

  def initialize(data_hash)
    @yaml_key = "my_service"
    super(data_hash)
  end
end

describe GetToWork::Service do
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
