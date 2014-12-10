require "spec_helper"

describe "NineGag" do
  it "should have NineGag as a provider" do
    Thornbed::Providers.constants.must_include(:NineGag)
  end

  it "should accept different NineGag urls" do
    ninegag = Thornbed::Providers::NineGag.new
    ninegag.valid?("http://9gag.com/gag/5931764").must_equal true
    ninegag.valid?("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg").must_equal true
    ninegag.valid?("http://9gag.com/gag/5929873?ref=popular").must_equal true
    ninegag.valid?("http://9gag.com/fast#5931764").must_equal true
  end

  it "should return OEmbed hash for NineGag urls" do
    ninegag = Thornbed::Providers::NineGag.new
    res = ninegag.get("http://9gag.com/gag/5931764")
    res["url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")

    res = ninegag.get("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
    res["url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")

    res = ninegag.get("http://9gag.com/gag/5929873?ref=popular")
    res["url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5929873_700b.jpg")

    res = ninegag.get("http://9gag.com/fast#5931764")
    res["url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
  end

  it "should discover NineGag provider" do
    res = Thornbed.get("http://9gag.com/gag/5931764")
    res["url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
    res["thumbnail_url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_fbthumbnail.jpg")
    res["page"].must_equal("http://9gag.com/gag/5931764")
    res["provider_name"].must_equal("NineGag")

    res = Thornbed.get("http://9gag.com/fast#5931764")
    res["url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_700b.jpg")
    res["thumbnail_url"].must_equal("http://d24w6bsrhbeh9d.cloudfront.net/photo/5931764_fbthumbnail.jpg")
    res["page"].must_equal("http://9gag.com/gag/5931764")
    res["provider_name"].must_equal("NineGag")
  end
end
