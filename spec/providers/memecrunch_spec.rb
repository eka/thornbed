require "spec_helper"

describe "Memecrunch" do
  it "should have Memecrunch as a provider" do
    Thornbed::Providers.constants.must_include(:Memecrunch)
  end

  it "should accept different Memecrunch urls" do
    memecrunch = Thornbed::Providers::Memecrunch.new
    memecrunch.valid?("http://memecrunch.com/meme/CHDE/when-browsing-r-new").must_equal true
    memecrunch.valid?("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png").must_equal true
    memecrunch.valid?("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75").must_equal true
  end

  it "should return OEmbed hash for Memecrunch urls" do
    memecrunch = Thornbed::Providers::Memecrunch.new
    res = memecrunch.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new")
    res["url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")

    res = memecrunch.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res["url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")

    res = memecrunch.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res["url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
  end

  it "should discover Memecrunch provider" do
    res = Thornbed.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new")
    res["url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res["thumbnail_url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res["page"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/")
    res["provider_name"].must_equal("Memecrunch")

    res = Thornbed.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res["url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res["thumbnail_url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res["page"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/")
    res["provider_name"].must_equal("Memecrunch")

    res = Thornbed.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res["url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res["thumbnail_url"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res["page"].must_equal("http://memecrunch.com/meme/CHDE/when-browsing-r-new/")
    res["provider_name"].must_equal("Memecrunch")
  end
end
