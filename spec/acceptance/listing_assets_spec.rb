require "spec_helper"

describe "Browsing Assets", :type => :request do
  it "should display info about an individual asset" do
    get "/stylish/meta/app/assets/javascripts/test.coffee"
    expect(json["digest"]).not_to be_empty
  end

  it "should display content from an individual asset" do
    get "/stylish/content/app/assets/javascripts/test.coffee"
    expect(response.body).to match(/require_self/)
  end

  it "should list the assets under a path" do
    get "/stylish/list/app/assets/javascripts"
    expect(json["path"]).to eq("app/assets/javascripts")
    expect(json["is_folder"]).to be_truthy
    expect(json["children"]).not_to be_empty
  end
end
