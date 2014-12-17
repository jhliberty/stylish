require "spec_helper"

describe Stylish::Library do
  let(:library) do
    Stylish::Library.load_from_disk(Stylish.fixtures_path)
    Stylish::Library.loaded.first
  end

  it "has some libraries loaded" do
    needle = library
    haystack = Stylish::Library.loaded
    expect(haystack).to include(needle)
  end

  it "lists all of the packages in the library" do
    expect(library.packages).not_to be_empty
    expect(library.packages.first).to be_a(Stylish::Package)
  end

  it "has a name of the packages" do
    expect(library.packages.map(&:name)).to include("Stylish test theme")
  end

  it "lets me find a package by name" do
    expect(library.find_package("Stylish test theme")).to be_a(Stylish::Package)
  end

  it "lets me find a package by slug" do
    expect(library.find_package("stylish-test-theme")).to be_a(Stylish::Package)
  end

end
