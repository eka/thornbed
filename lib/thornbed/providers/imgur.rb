require "uri"
require "thornbed"

module Thornbed::Providers
  class Imgur < Thornbed::Providers::Provider
    attr_reader :type, :provider_url

    def initialize
      @pattern = /^http(s)?:\/\/((i\.)|(www\.))?imgur.com\/(gallery\/)?(\w){5}(s|l|b|m|t)?(\.gif|\.jpg|.jpeg|\.png)?(\?full)?$/
      @type = "photo"
      @provider_url = "http://imgur.com"
    end

    def get(url)
      raise Thornbed::NotValid, url if !self.valid?(url)
      url = URI.parse(url)
      gallery = /gallery/ =~ url.path
      direct = /\/(\w){5}(\.gif|\.jpg|\.jpeg|\.png)$/.match(url.path)
      thumb = /\/(\w){5}(s|l|b|m|t)(\.gif|\.jpg|\.jpeg|\.png)$/.match(url.path)
      page = /\/(\w){5}$/ =~ url.path
      ptype = "jpg"

      if page || gallery
        pic_id = /(\/gallery\/)?\/(\w)*$/.match(url.path)[0][1..-1]
      elsif thumb
        pic_id = thumb[0][1..5]
      elsif direct
        pic_id = direct[0][1..5]
        ptype = /(\.gif|\.jpg|\.jpeg|\.png)$/.match(url.path)[0][1..-1]
      else
        raise Thornbed::NotValid, url
      end

      {
        url: "http://i.imgur.com/#{pic_id}.#{ptype}",
        type: "#{type}",
        provider_name: self.provider_name,
        provider_url: provider_url,
        thumbnail_url: "http://i.imgur.com/#{pic_id}s.#{ptype}",
        version: "1.0",
        page: "http://imgur.com/#{pic_id}",
        width: nil,
        height: nil
      }
    end
  end
end
