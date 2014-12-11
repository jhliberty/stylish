require "spec_helper"

describe Stylish::Package do
  let(:package) { Stylish::Package.new(Stylish.fixtures_path.join("test-theme")) }

  it "has a manifest" do
    expect(package.manifest.root).to eq(package.root)
  end
end
