require "spec_helper"

describe Thornbed do
  it "should rely on ruby-oembed when querying for a oembed provider" do
    good_response = {"html"=>"<iframe width=\"459\" height=\"344\" src=\"http://www.youtube.com/embed/xJbJayhYxG4?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>", "height"=>344, "provider_name"=>"YouTube", "title"=>"How can I know if God Exists?", "author_name"=>"Balarama Lila Das", "version"=>"1.0", "width"=>459, "author_url"=>"http://www.youtube.com/user/radhanathswamionline", "thumbnail_height"=>360, "type"=>"video", "thumbnail_url"=>"http://i.ytimg.com/vi/xJbJayhYxG4/hqdefault.jpg", "provider_url"=>"http://www.youtube.com/", "thumbnail_width"=>480}
    FakeWeb.register_uri(:get, /http(s)?:\/\/*(\.)?google\.com\/*/, body: good_response)
    url = "http://www.youtube.com/watch?v=xJbJayhYxG4&feature=g-vrec"
    res = Thornbed.get(url)

    res.must_equal good_response
  end

  it "should raise an error when calling get on a bad url" do
    imgur = Thornbed::Providers::Imgur.new
    lambda { imgur.get('http://imgur.com/none.jpg') }.must_raise(Thornbed::NotValid)
  end

  it "should raise an error when pattern is not set" do
    foo = Thornbed::Providers::Provider.new
    lambda { foo.get('http://imgur.com/none.jpg') }.must_raise(NotImplementedError)
  end
end