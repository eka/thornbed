require "spec_helper"

describe "Memegenerator" do
  it "should have Memegenerator as a provider" do
    Thornbed::Providers.constants.must_include(:Memegenerator)
  end

  it "should accept different Memegenerator urls" do
    memegenerator = Thornbed::Providers::Memegenerator.new
    memegenerator.valid?("http://memegenerator.net/instance/30688283").must_equal true
    memegenerator.valid?("http://cdn.memegenerator.net/instances/400x/30688283.jpg").must_equal true
    memegenerator.valid?("http://memegenerator.net/instance/30691419?browsingOrder=Popular&browsingTimeSpan=Today").must_equal true
  end

  it "should return OEmbed hash for Memegenerator urls" do
    memegenerator = Thornbed::Providers::Memegenerator.new
    res = memegenerator.get("http://memegenerator.net/instance/30688283")
    res["url"].must_equal "http://cdn.memegenerator.net/instances/400x/30688283.jpg"
    # res.must_include("url" => "http://cdn.memegenerator.net/instances/400x/30688283.jpg")
  end

  it "should discover Memegenerator provider" do
    res = Thornbed.get("http://memegenerator.net/instance/30688283")
    res["url"].must_equal("http://cdn.memegenerator.net/instances/400x/30688283.jpg")
    res["thumbnail_url"].must_equal("http://cdn.memegenerator.net/instances/100x/30688283.jpg")
    res["provider_name"].must_equal("Memegenerator")
  end
end
