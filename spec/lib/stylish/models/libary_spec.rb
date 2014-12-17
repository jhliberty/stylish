require "spec_helper"

describe Stylish::Library do
  let(:library) do
    Stylish::Library.load_from_disk(Stylish.fixtures_path)
    Stylish::Library.loaded.first
  end

  it "lists all of the packages in the library" do
    expect(library.packages.length).to eq(1)
    expect(library.packages.first).to be_a(Stylish::Package)
  end

  it "has a name of the packages" do
    expect(library.packages.first.name).to eq("Stylish test theme")
  end
end
