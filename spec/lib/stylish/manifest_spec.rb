require "spec_helper"

describe Stylish::Manifest do
  let(:json) do
    Stylish::Manifest.new(Stylish.fixtures_path.join("test-theme","manifest.json"))
  end

  let(:yaml) do
    Stylish::Manifest.new(Stylish.fixtures_path.join("test-theme","manifest.yml"))
  end

  let(:manifest) { json }

  it "accepts a path to a JSON file" do
    expect(json.path).to be_exist
    expect(json.format).to eq("json")
  end

  it "accepts a path to a YAML file" do
    expect(yaml.path).to be_exist
    expect(yaml.format).to eq("yml")
  end

  it "reads the manifest" do
    expect(manifest.name).to eq("Stylish test theme")
    expect(manifest.categories).to include("Headers","Footers","Landing Page Blocks")
  end

  it "has a root folder" do
    expect(manifest.root).to be_exist
    expect(manifest.root).to be_directory
  end

  it "has a templates folder" do
    expect(manifest.templates).to be_directory
    expect(manifest.templates).to be_exist
  end

  it "has a stylesheets folder" do
    expect(manifest.stylesheets).to be_exist
    expect(manifest.stylesheets).to be_directory
  end

  it "has a scripts folder" do
    expect(manifest.scripts).to be_exist
    expect(manifest.scripts).to be_directory
  end
end
