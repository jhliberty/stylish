require "spec_helper"

describe Stylish::Developer::Server do
  it "should return info about itself" do
    info = Stylish::Developer::Server.info_response
    expect(info).not_to be_empty
  end
end
