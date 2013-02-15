require "spec_helper"

describe Thornbed do
  it "should rely on ruby-oembed when querying for a oembed provider" do
    good_response = {"thumbnail_width"=>480, "author_url"=>"http://www.youtube.com/user/radhanathswamionline", "version"=>"1.0", "type"=>"video", "thumbnail_height"=>360, "provider_url"=>"http://www.youtube.com/", "thumbnail_url"=>"http://i1.ytimg.com/vi/xJbJayhYxG4/hqdefault.jpg", "html"=>"<iframe width=\"459\" height=\"344\" src=\"http://www.youtube.com/embed/xJbJayhYxG4?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>", "provider_name"=>"YouTube", "height"=>344, "title"=>"How can I know if God Exists?", "width"=>459, "author_name"=>"Balarama Lila Das"}
    FakeWeb.register_uri(:get, /http(s)?:\/\/*(\.)?google\.com\/*/, body: good_response)
    url = "http://www.youtube.com/watch?v=xJbJayhYxG4&feature=g-vrec"
    res = Thornbed.get(url)

    res.should == good_response
  end

  it "should raise an error when calling get on a bad url" do
    imgur = Thornbed::Providers::Imgur.new
    lambda { imgur.get('http://imgur.com/none.jpg') }.should raise_error(Thornbed::NotValid)
  end

  it "should raise an error when pattern is not set" do
    foo = Thornbed::Providers::Provider.new
    lambda { foo.get('http://imgur.com/none.jpg') }.should raise_error(NotImplementedError)
  end
end