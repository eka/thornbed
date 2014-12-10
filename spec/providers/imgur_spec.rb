require "spec_helper"

describe "Imgur" do
  it "should have Imgur as a provider" do
    Thornbed::Providers.constants.must_include(:Imgur)
  end

  it "should accept different imgur urls" do
    imgur = Thornbed::Providers::Imgur.new
    imgur.valid?('http://imgur.com/gallery/A0TP9').must_equal true
    imgur.valid?('http://i.imgur.com/A0TP9.png').must_equal true
    imgur.valid?('http://i.imgur.com/A0TP9.gif').must_equal true
    imgur.valid?('http://i.imgur.com/A0TP9.jpg').must_equal true
    imgur.valid?('http://i.imgur.com/PFaps.jpg').must_equal true
    imgur.valid?('http://imgur.com/SruWT?full').must_equal true
    imgur.valid?('http://i.imgur.com/DE7Rbl.jpg').must_equal true
    imgur.valid?('http://i.imgur.com/N2IDN.gif').must_equal true
    imgur.valid?('http://i.imgur.com/A0TP9s.jpg').must_equal true
    imgur.valid?('http://www.imgur.com/RUUuR.jpeg').must_equal true
    imgur.valid?('http://i.imgur.com/9XPKUJLh.jpg').must_equal true
    imgur.valid?('http://imgur.com/LcbbCHv').must_equal true
    imgur.valid?('http://imgur.com/0TczaPb').must_equal true
    imgur.valid?('http://imgur.com/none').must_equal false
    imgur.valid?('http://imgur.com/none.jpg').must_equal false
    imgur.valid?('http://imgur.com/a/pq0N2').must_equal false
  end

  it "should return OEmbed hash for imgur urls" do
    imgur = Thornbed::Providers::Imgur.new
    res = imgur.get('http://imgur.com/gallery/A0TP9')
    res["url"].must_equal( 'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://i.imgur.com/A0TP9.png')
    res["url"].must_equal( 'http://i.imgur.com/A0TP9.png')

    res = imgur.get('http://i.imgur.com/A0TP9.gif')
    res["url"].must_equal( 'http://i.imgur.com/A0TP9.gif')

    res = imgur.get('http://i.imgur.com/A0TP9.jpg')
    res["url"].must_equal( 'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://i.imgur.com/PFaps.jpg')
    res["url"].must_equal( 'http://i.imgur.com/PFaps.jpg')

    res = imgur.get('http://imgur.com/SruWT?full')
    res["url"].must_equal( 'http://i.imgur.com/SruWT.jpg')

    res = imgur.get('http://i.imgur.com/DE7Rbl.jpg')
    res["url"].must_equal( 'http://i.imgur.com/DE7Rb.jpg')

    res = imgur.get('http://i.imgur.com/N2IDN.gif')
    res["url"].must_equal( 'http://i.imgur.com/N2IDN.gif')

    res = imgur.get('http://i.imgur.com/A0TP9s.jpg')
    res["url"].must_equal( 'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://www.imgur.com/RUUuR.jpeg')
    res["url"].must_equal( 'http://i.imgur.com/RUUuR.jpeg')

    res = imgur.get('http://imgur.com/LcbbCHv')
    res["url"].must_equal( 'http://i.imgur.com/LcbbCHv.jpg')

    res = imgur.get('http://i.imgur.com/LcbbCHvs.jpg')
    res["url"].must_equal( 'http://i.imgur.com/LcbbCHv.jpg')

    res = imgur.get('http://imgur.com/0TczaPb')
    res["url"].must_equal( 'http://i.imgur.com/0TczaPb.jpg')

    res = imgur.get('http://i.imgur.com/xQdLBoVl.jpg')
    res["url"].must_equal( 'http://i.imgur.com/xQdLBoV.jpg')
    
    res = imgur.get('http://i.imgur.com/9XPKUJLh.jpg')
    res["url"].must_equal( 'http://i.imgur.com/9XPKUJL.jpg')

    res = imgur.get('http://imgur.com/66SNOva')
    res["url"].must_equal('http://i.imgur.com/66SNOva.jpg')

    lambda { imgur.get('http://imgur.com/none') }.must_raise(Thornbed::NotValid)
    lambda { imgur.get('http://imgur.com/none.jpg') }.must_raise(Thornbed::NotValid)
    lambda { imgur.get('http://imgur.com/a/pq0N2') }.must_raise(Thornbed::NotValid)
  end

  it "should discover Imgur provider" do
    res = Thornbed.get('http://imgur.com/N2IDN')
    res["url"].must_equal( 'http://i.imgur.com/N2IDN.jpg')
    res["provider_name"].must_equal("Imgur")
  end
end
