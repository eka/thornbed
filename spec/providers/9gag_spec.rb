require "spec_helper"

describe "NineGag" do
  it "should have NineGag as a provider" do
    Thornbed::Providers.constants.should include(:NineGag)
  end

  it "should accept different NineGag urls" do
    ninegag = Thornbed::Providers::NineGag.new
    ninegag.valid?("http://9gag.com/gag/5931764").should be_true
    ninegag.valid?("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg").should be_true
    ninegag.valid?("http://9gag.com/gag/5929873?ref=popular").should be_true
    ninegag.valid?("http://9gag.com/fast#5931764").should be_true
  end

  it "should return OEmbed hash for NineGag urls" do
    ninegag = Thornbed::Providers::NineGag.new
    res = ninegag.get("http://9gag.com/gag/5931764")
    res.should include("url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")

    res = ninegag.get("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
    res.should include("url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")

    res = ninegag.get("http://9gag.com/gag/5929873?ref=popular")
    res.should include("url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5929873_700b.jpg")

    res = ninegag.get("http://9gag.com/fast#5931764")
    res.should include("url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
  end

  it "should discover NineGag provider" do
    res = Thornbed.get("http://9gag.com/gag/5931764")
    res.should include("url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
    res.should include("thumbnail_url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_fbthumbnail.jpg")
    res.should include("page" => "http://9gag.com/gag/5931764")
    res.should include("provider_name" => "NineGag")

    res = Thornbed.get("http://9gag.com/fast#5931764")
    res.should include("url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
    res.should include("thumbnail_url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_fbthumbnail.jpg")
    res.should include("page" => "http://9gag.com/gag/5931764")
    res.should include("provider_name" => "NineGag")
  end
end
