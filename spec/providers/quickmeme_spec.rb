require "spec_helper"

describe "QuickMeme" do
  it "should have QuickMeme as a provider" do
    Thornbed::Providers.constants.should include(:QuickMeme)
  end

  it "should accept different quickmeme urls" do
    quickmeme = Thornbed::Providers::QuickMeme.new
    quickmeme.valid?('http://i.qkme.me/353dum.jpg').should be_true
    quickmeme.valid?('http://t.qkme.me/353dum.jpg').should be_true
    quickmeme.valid?('http://www.quickmeme.com/meme/353dum/').should be_true
    quickmeme.valid?('http://qkme.me/353i1m?id=189959962').should be_true
    quickmeme.valid?('http://www.quickmeme.com/meme/3rt124/#by=ad').should be_true
    quickmeme.valid?('http://www.quickmeme.com/meme/3rtne7/').should be_true
    quickmeme.valid?('http://qkme.me/353i1ma').should be_false
    quickmeme.valid?('http://www.quickmeme.com/meme/353duma/').should be_false
    quickmeme.valid?('http://i.qkme.me/353duma.jpg').should be_false
  end

  it "should return OEmbed hash for quickmeme urls" do
    quickmeme = Thornbed::Providers::QuickMeme.new
    res = quickmeme.get('http://i.qkme.me/353dum.jpg')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://t.qkme.me/353dum.jpg')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://www.quickmeme.com/meme/353dum/')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://qkme.me/353i1m?id=189959962')
    res.should include(url: 'http://i.qkme.me/353i1m.jpg')

    res = quickmeme.get('http://qkme.me/353dum')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')

    res = quickmeme.get('http://www.quickmeme.com/meme/3rtne7/')
    res.should include(url: 'http://i.qkme.me/3rtne7.jpg')

    lambda { quickmeme.get('http://qkme.me/353i1ma') }.should raise_error(Thornbed::NotValid)
    lambda { quickmeme.get('http://www.quickmeme.com/meme/353duma/') }.should raise_error(Thornbed::NotValid)
    lambda { quickmeme.get('http://i.qkme.me/353duma.jpg') }.should raise_error(Thornbed::NotValid)
  end

  it "should discover Imgur provider" do
    res = Thornbed.get('http://qkme.me/353dum')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')
    res.should include(provider_name: "QuickMeme")

    res = Thornbed.get('http://www.quickmeme.com/meme/353dum/')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')
    res.should include(provider_name: "QuickMeme")

    res = Thornbed.get('http://t.qkme.me/353dum.jpg')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')
    res.should include(provider_name: "QuickMeme")

    res = Thornbed.get('http://qkme.me/353i1m?id=189959962')
    res.should include(url: 'http://i.qkme.me/353i1m.jpg')
    res.should include(provider_name: "QuickMeme")

    res = Thornbed.get('http://qkme.me/353dum')
    res.should include(url: 'http://i.qkme.me/353dum.jpg')
    res.should include(provider_name: "QuickMeme")
  end
end
