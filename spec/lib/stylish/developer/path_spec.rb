require "spec_helper"

describe Stylish::Developer::Path do
  describe "Meta Requests" do
    subject { Stylish::Developer::Path.new("app/assets/javascripts/test.coffee", "meta") }

    it { is_expected.to be_meta }
    it { is_expected.to be_success }
  end

  describe "Content Requests" do
    subject { Stylish::Developer::Path.new("app/assets/javascripts/test.coffee", "content") }
    it { is_expected.not_to be_meta }
    it { is_expected.not_to be_not_found }
  end

  describe "Responses for paths" do
    let(:not_found) { Stylish::Developer::Path.new("/stylish/content/whatever") }
    let(:coffeescript) { Stylish::Developer::Path.new("app/assets/javascripts/test.coffee", "meta") }
    let(:scss) { Stylish::Developer::Path.new("app/assets/stylesheets/test.css.scss", "meta") }

    it "should recognize requests for paths which are not found" do
      expect(not_found).to be_not_found
    end

    it "should recognize the file types of given requests" do
      expect(coffeescript.extension).to eq(".coffee")
      expect(coffeescript.content_type).to eq("application/javascript")
    end

    it "should recognize the file types of given requests" do
      expect(scss.extension).to eq(".scss")
      expect(scss.content_type).to eq("text/css")
    end
  end
end
