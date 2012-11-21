require "spec_helper"

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

  it "should raise an error when calling get on a bad url" do
    imgur = Thornbed::Providers::Imgur.new
    lambda { imgur.get('http://imgur.com/none.jpg') }.should raise_error(Thornbed::NotValid)
  end
end
