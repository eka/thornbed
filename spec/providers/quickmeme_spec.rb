require "spec_helper"

describe "QuickMeme" do
  it "should have QuickMeme as a provider" do
    Thornbed::Providers.constants.must_include(:QuickMeme)
  end

  it "should accept different quickmeme urls" do
    quickmeme = Thornbed::Providers::QuickMeme.new
    quickmeme.valid?('http://i.qkme.me/353dum.jpg').must_equal true
    quickmeme.valid?('http://t.qkme.me/353dum.jpg').must_equal true
    quickmeme.valid?('http://www.quickmeme.com/meme/353dum/').must_equal true
    quickmeme.valid?('http://qkme.me/353i1m?id=189959962').must_equal true
    quickmeme.valid?('http://www.quickmeme.com/meme/3rt124/#by=ad').must_equal true
    quickmeme.valid?('http://www.quickmeme.com/meme/3rtne7/').must_equal true
    quickmeme.valid?('http://qkme.me/353i1ma').must_equal false
    quickmeme.valid?('http://www.quickmeme.com/meme/353duma/').must_equal false
    quickmeme.valid?('http://i.qkme.me/353duma.jpg').must_equal false
  end

  it "should return OEmbed hash for quickmeme urls" do
    quickmeme = Thornbed::Providers::QuickMeme.new
    res = quickmeme.get('http://i.qkme.me/353dum.jpg')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://t.qkme.me/353dum.jpg')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://www.quickmeme.com/meme/353dum/')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://qkme.me/353i1m?id=189959962')
    res["url"].must_equal('http://i.qkme.me/353i1m.jpg')

    res = quickmeme.get('http://qkme.me/353dum')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://www.quickmeme.com/meme/3rtne7/')
    res["url"].must_equal('http://i.qkme.me/3rtne7.jpg')

    lambda { quickmeme.get('http://qkme.me/353i1ma') }.must_raise(Thornbed::NotValid)
    lambda { quickmeme.get('http://www.quickmeme.com/meme/353duma/') }.must_raise(Thornbed::NotValid)
    lambda { quickmeme.get('http://i.qkme.me/353duma.jpg') }.must_raise(Thornbed::NotValid)
  end

  it "should discover Imgur provider" do
    res = Thornbed.get('http://qkme.me/353dum')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')
    res["provider_name"].must_equal("QuickMeme")

    res = Thornbed.get('http://www.quickmeme.com/meme/353dum/')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')
    res["provider_name"].must_equal("QuickMeme")

    res = Thornbed.get('http://t.qkme.me/353dum.jpg')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')
    res["provider_name"].must_equal("QuickMeme")

    res = Thornbed.get('http://qkme.me/353i1m?id=189959962')
    res["url"].must_equal('http://i.qkme.me/353i1m.jpg')
    res["provider_name"].must_equal("QuickMeme")

    res = Thornbed.get('http://qkme.me/353dum')
    res["url"].must_equal('http://i.qkme.me/353dum.jpg')
    res["provider_name"].must_equal("QuickMeme")
  end
end
