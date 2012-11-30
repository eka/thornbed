require "uri"
require "thornbed"

module Thornbed::Providers
  class QuickMeme < Thornbed::Providers::Provider
    attr_accessor :pattern

    def initialize
      self.pattern = /http(s)?:\/\/(i|t)?(\.)?(www\.)?(quickmeme.com|qkme.me)\/(meme\/)?(\w){6}(\/)?(.jpg)?((\?|#).*)?$/
    end

    def get(url)
      raise Thornbed::NotValid, url if !valid?(url)
      url = URI.parse(url)
      normal = /quickmeme.com/ =~ url.to_s
      direct = /qkme.me/ =~ url.to_s
      ptype = "jpg"
      if normal
        pic_id = /(\w){6}/.match(url.path)
      elsif direct
        pic_id = url.path[/(\w){6}(.jpg)?/ =~ url.path..6]
      else
        raise Thornbed::NotValid, url
      end

      {
        url: "http://i.qkme.me/#{pic_id}.#{ptype}",
        type: "photo",
        provider_name: provider_name,
        provider_url: "http://quickmeme.com",
        thumbnail_url: "http://t.qkme.me/#{pic_id}.#{ptype}",
        version: "1.0",
        page: "http://quickmeme.com/#{pic_id}/",
        width: nil,
        height: nil
      }
    end
  end
end
