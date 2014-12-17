require "spec_helper"

describe Stylish::Package do
  let(:package) do
    Stylish::Package.new(root: Stylish.fixtures_path.join("test-theme"))
  end

  it "has a manifest" do
    expect(package.manifest.root).to eq(package.root)
  end
end
