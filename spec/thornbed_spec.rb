require "spec_helper"
require "fakeweb"
require "thornbed"

describe Thornbed do

  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end

  it "should rely on ruby-oembed when querying for a oembed provider" do
    good_response = {
      "provider_url"=>"http://www.youtube.com/",
      "thumbnail_url"=>"http://i1.ytimg.com/vi/xJbJayhYxG4/hqdefault.jpg",
      "title"=>"How can I know if God Exists?",
      "html"=>
      "<iframe width=\"459\" height=\"344\" src=\"http://www.youtube.com/embed/xJbJayhYxG4?fs=1&feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>",
      "author_name"=>"radhanathswamionline",
      "height"=>344,
      "thumbnail_width"=>480,
      "width"=>459,
      "version"=>"1.0",
      "author_url"=>"http://www.youtube.com/user/radhanathswamionline",
      "provider_name"=>"YouTube",
      "type"=>"video",
      "thumbnail_height"=>360
    }
    FakeWeb.register_uri(:get, /http(s)?:\/\/*(\.)?google\.com\/*/, body: good_response)
    url = "http://www.youtube.com/watch?v=xJbJayhYxG4&feature=g-vrec"
    res = Thornbed.get(url)

    res.should == good_response
  end

  it "should have Imgur as a provider" do
    Thornbed::Providers.constants.include?(:Imgur).should_not be_false
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
    imgur.valid?('http://imgur.com/none').should be_false
    imgur.valid?('http://imgur.com/none.jpg').should be_false
    imgur.valid?('http://imgur.com/a/pq0N2').should be_false
  end

  it "should raise an error when calling get on a bad url" do
    imgur = Thornbed::Providers::Imgur.new
    lambda { imgur.get('http://imgur.com/none.jpg') }.should raise_error(Thornbed::NotValid)
  end

  it "should return OEmbed hash for imgur urls" do
    imgur = Thornbed::Providers::Imgur.new
    res = imgur.get('http://imgur.com/gallery/A0TP9')
    res.should include(url: 'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://i.imgur.com/A0TP9.png')
    res.should include(url: 'http://i.imgur.com/A0TP9.png')


    res = imgur.get('http://i.imgur.com/A0TP9.gif')
    res.should include(url: 'http://i.imgur.com/A0TP9.gif')

    res = imgur.get('http://i.imgur.com/A0TP9.jpg')
    res.should include(url: 'http://i.imgur.com/A0TP9.jpg')

    res = imgur.get('http://i.imgur.com/PFaps.jpg')
    res.should include(url: 'http://i.imgur.com/PFaps.jpg')

    res = imgur.get('http://imgur.com/SruWT?full')
    res.should include(url: 'http://i.imgur.com/SruWT.jpg')

    res = imgur.get('http://i.imgur.com/DE7Rbl.jpg')
    res.should include(url: 'http://i.imgur.com/DE7Rb.jpg')

    res = imgur.get('http://i.imgur.com/N2IDN.gif')
    res.should include(url: 'http://i.imgur.com/N2IDN.gif')

    res = imgur.get('http://i.imgur.com/A0TP9s.jpg')
    res.should include(url: 'http://i.imgur.com/A0TP9.jpg')

    lambda { imgur.get('http://imgur.com/none') }.should raise_error(Thornbed::NotValid)
    lambda { imgur.get('http://imgur.com/none.jpg') }.should raise_error(Thornbed::NotValid)
    lambda { imgur.get('http://imgur.com/a/pq0N2') }.should raise_error(Thornbed::NotValid)
  end

end