require "spec_helper"

describe "Browsing Models", :type => :request do
  it "lets me browse the packages in the library" do
    get "/stylish/models/browse/packages"
    expect(response.status).to eq(200)
  end

  it "lets me find an individual package details" do
    get "/stylish/models/show/packages/stylish-test-theme"
    expect(response.body).to include("Stylish test theme")
  end
end
