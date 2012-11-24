require "spec_helper"

describe "Memegenerator" do
  it "should have Memegenerator as a provider" do
    Thornbed::Providers.constants.should include(:Memegenerator)
  end

  it "should accept different Memegenerator urls" do
    memegenerator = Thornbed::Providers::Memegenerator.new
    memegenerator.valid?("http://memegenerator.net/instance/30688283").should be_true
    memegenerator.valid?("http://cdn.memegenerator.net/instances/400x/30688283.jpg").should be_true
    memegenerator.valid?("http://memegenerator.net/instance/30691419?browsingOrder=Popular&browsingTimeSpan=Today").should be_true
  end

  it "should return OEmbed hash for Memegenerator urls" do
    memegenerator = Thornbed::Providers::Memegenerator.new
    res = memegenerator.get("http://memegenerator.net/instance/30688283")
    res.should include(url: "http://cdn.memegenerator.net/instances/400x/30688283.jpg")
  end

  it "should discover Memegenerator provider" do
    res = Thornbed.get("http://memegenerator.net/instance/30688283")
    res.should include(url: "http://cdn.memegenerator.net/instances/400x/30688283.jpg")
    res.should include(thumbnail_url: "http://cdn.memegenerator.net/instances/100x/30688283.jpg")
    res.should include(provider_name: "Memegenerator")
  end
end
