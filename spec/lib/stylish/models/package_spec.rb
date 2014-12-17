require "spec_helper"

describe Stylish::Package do
  let(:library) do
    Stylish::Library.load_from_disk(Stylish.fixtures_path)
    Stylish::Library.loaded.first
  end

  let(:package) do
    library.packages.first
  end

  it "has a manifest" do
    expect(package.manifest.root).to eq(package.root)
  end

  it "has a relationship to the library" do
    expect(package.library).to eq(library)
  end

  it "creates the folder structure it needs for new packages" do
    begin
      created_package = Stylish::Package.new(name: "Created Theme", library: library)
      created_package.initialize_folder_structure

      expect(created_package.manifest).to be_present
      expect(created_package.root).to be_exist
    ensure
      FileUtils.rm_rf(created_package.root) rescue nil
    end
  end
end
