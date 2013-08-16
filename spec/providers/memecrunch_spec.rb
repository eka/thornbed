require "spec_helper"

describe "Memecrunch" do
  it "should have Memecrunch as a provider" do
    Thornbed::Providers.constants.should include(:Memecrunch)
  end

  it "should accept different Memecrunch urls" do
    memecrunch = Thornbed::Providers::Memecrunch.new
    memecrunch.valid?("http://memecrunch.com/meme/CHDE/when-browsing-r-new").should be_true
    memecrunch.valid?("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png").should be_true
    memecrunch.valid?("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75").should be_true
  end

  it "should return OEmbed hash for Memecrunch urls" do
    memecrunch = Thornbed::Providers::Memecrunch.new
    res = memecrunch.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new")
    res.should include("url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")

    res = memecrunch.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res.should include("url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")

    res = memecrunch.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res.should include("url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
  end

  it "should discover Memecrunch provider" do
    res = Thornbed.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new")
    res.should include("url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res.should include("thumbnail_url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res.should include("page" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/")
    res.should include("provider_name" => "Memecrunch")

    res = Thornbed.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res.should include("url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res.should include("thumbnail_url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res.should include("page" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/")
    res.should include("provider_name" => "Memecrunch")

    res = Thornbed.get("http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res.should include("url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png")
    res.should include("thumbnail_url" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/image.png?w=75")
    res.should include("page" => "http://memecrunch.com/meme/CHDE/when-browsing-r-new/")
    res.should include("provider_name" => "Memecrunch")
  end
end
