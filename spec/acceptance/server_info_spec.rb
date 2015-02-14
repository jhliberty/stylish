require "spec_helper"

describe Stylish::Developer::Server, :type => :request do
  it "should return info about the Stylish server" do
    get "/stylish/info"
    expect(json["sprockets_paths"]).not_to be_empty
    expect(json["root"]).to be_present
  end
end

