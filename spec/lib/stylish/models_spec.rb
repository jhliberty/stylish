require "spec_helper"

describe Stylish::Models do
  it "has a list of types" do
    expect(Stylish::Models::Types).not_to be_empty
  end

  it "lets me lookup a model" do
    expect(Stylish::Models.lookup("packages")).to eq(Stylish::Package)
    expect(Stylish::Models.lookup("package")).to eq(Stylish::Package)
  end
end
