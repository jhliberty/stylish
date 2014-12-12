require "spec_helper"

describe Stylish::Configuration do
  it "lets me load a file from disk" do
    Stylish.config.load_from_file Stylish.fixtures_path.join("config.json")
    expect(Stylish.config.loaded).to eq("value")
  end
end
