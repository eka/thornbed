require "spec_helper"

describe "Imgur" do
  it "should have Imgur as a provider" do
    Thornbed::Providers.constants.should include(:Imgur)
  end

  it "should accept different imgur urls" do
    imgur = Thornbed::Providers::Imgur.new
    imgur.valid?('http://imgur.com/gallery/A0TP9').should be_true
    imgur.valid?('http://i.imgur.com/A0TP9.png').should be_true
    imgur.valid?('http://i.imgur.com/A0TP9.gif').should be_true
    imgur.valid?('http://i.imgur.com/A0TP9.jpg').should be_true
    imgur.valid?('http://i.imgur.com/PFaps.jpg').should be_true
    imgur.valid?('http://imgur.com/SruWT?full').should be_true
    imgur.valid?('http://i.imgur.com/DE7Rbl.jpg').should be_true
    imgur.valid?('http://i.imgur.com/N2IDN.gif').should be_true
    imgur.valid?('http://i.imgur.com/A0TP9s.jpg').should be_true
    imgur.valid?('http://www.imgur.com/RUUuR.jpeg').should be_true
    imgur.valid?('http://i.imgur.com/9XPKUJLh.jpg').should be_true
    imgur.valid?('http://imgur.com/LcbbCHv').should be_true
    imgur.valid?('http://imgur.com/0TczaPb').should be_true
    imgur.valid?('http://imgur.com/none').should be_false
    imgur.valid?('http://imgur.com/none.jpg').should be_false
    imgur.valid?('http://imgur.com/a/pq0N2').should be_false
  end

  it "should return OEmbed hash for imgur urls" do
    imgur = Thornbed::Providers::Imgur.new
    res = imgur.get('http://imgur.com/gallery/A0TP9')
    res.should include("url" =>  'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://i.imgur.com/A0TP9.png')
    res.should include("url" =>  'http://i.imgur.com/A0TP9.png')

    res = imgur.get('http://i.imgur.com/A0TP9.gif')
    res.should include("url" =>  'http://i.imgur.com/A0TP9.gif')

    res = imgur.get('http://i.imgur.com/A0TP9.jpg')
    res.should include("url" =>  'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://i.imgur.com/PFaps.jpg')
    res.should include("url" =>  'http://i.imgur.com/PFaps.jpg')

    res = imgur.get('http://imgur.com/SruWT?full')
    res.should include("url" =>  'http://i.imgur.com/SruWT.jpg')

    res = imgur.get('http://i.imgur.com/DE7Rbl.jpg')
    res.should include("url" =>  'http://i.imgur.com/DE7Rb.jpg')

    res = imgur.get('http://i.imgur.com/N2IDN.gif')
    res.should include("url" =>  'http://i.imgur.com/N2IDN.gif')

    res = imgur.get('http://i.imgur.com/A0TP9s.jpg')
    res.should include("url" =>  'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://www.imgur.com/RUUuR.jpeg')
    res.should include("url" =>  'http://i.imgur.com/RUUuR.jpeg')

    res = imgur.get('http://imgur.com/LcbbCHv')
    res.should include("url" =>  'http://i.imgur.com/LcbbCHv.jpg')

    res = imgur.get('http://i.imgur.com/LcbbCHvs.jpg')
    res.should include("url" =>  'http://i.imgur.com/LcbbCHv.jpg')

    res = imgur.get('http://imgur.com/0TczaPb')
    res.should include("url" =>  'http://i.imgur.com/0TczaPb.jpg')

    res = imgur.get('http://i.imgur.com/xQdLBoVl.jpg')
    res.should include("url" =>  'http://i.imgur.com/xQdLBoV.jpg')
    
    res = imgur.get('http://i.imgur.com/9XPKUJLh.jpg')
    res.should include("url" =>  'http://i.imgur.com/9XPKUJL.jpg')

    lambda { imgur.get('http://imgur.com/none') }.should raise_error(Thornbed::NotValid)
    lambda { imgur.get('http://imgur.com/none.jpg') }.should raise_error(Thornbed::NotValid)
    lambda { imgur.get('http://imgur.com/a/pq0N2') }.should raise_error(Thornbed::NotValid)
  end

  it "should discover Imgur provider" do
    res = Thornbed.get('http://imgur.com/N2IDN')
    res.should include("url" =>  'http://i.imgur.com/N2IDN.jpg')
    res.should include("provider_name" => "Imgur")
  end
end
