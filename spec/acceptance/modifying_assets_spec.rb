require "spec_helper"

describe "Modifying Assets", :type => :request do
  before(:all) do
    created = Stylish.test_javascript_path.join("writable","created.coffee")
    FileUtils.rm_rf(created) if created.exist?
  end

  let(:created) { Stylish.test_javascript_path.join("writable","created.coffee") }
  let(:existing) { Stylish.test_javascript_path.join("writable","existing.coffee") }

  it "should let me create a new asset" do
    begin
      $k = true
      path = "/stylish/create/app/assets/javascripts/writable/created.coffee"
      post(path, contents: "console.log(true) if true")

      expect(response.status).to eq(200)
      expect(json["digest"]).to be_present
      expect(json["urls"]).not_to be_empty
      expect(created).to be_exist
      expect(created.read).to include("console.log")
    ensure
      file_path = Stylish.test_javascript_path.join("writable","created.coffee")
      FileUtils.rm_rf(file_path) if file_path.exist?
      $k = false
    end
  end

  it "should let me update the contents of an asset" do
    needle = rand(36**18).to_s(36)
    path = "/stylish/update/app/assets/javascripts/writable/existing.coffee"
    post(path, contents: "console.log('#{needle}')")

    expect(response.status).to eq(200)
    expect(json["digest"]).to be_present
    expect(json["urls"]).not_to be_empty
    expect(existing.read).to include(needle)
  end

  it "should let me remove an asset" do
    created.open("w+") {|fh| fh.write("#delete me") }

    path = "/stylish/delete/app/assets/javascripts/writable/created.coffee"
    post(path, contents: "console.log(true) if true")

    expect(response.status).to eq(200)
    expect(created).not_to be_exist
  end
end
