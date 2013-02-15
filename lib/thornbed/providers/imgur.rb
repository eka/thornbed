require "uri"
require "thornbed"

module Thornbed::Providers
  class Imgur < Thornbed::Providers::Provider
    attr_accessor :pattern

    def initialize
      self.pattern = /^https?:\/\/(www\.|i\.)?imgur\.com\/(gallery\/)?(?<pid>\w{5,})(s|l|b|m|t)?(?<ptype>\.gif|\.jpg|\.jpeg|\.png)?(\?full)?$/
    end

    def get(url)
      raise Thornbed::NotValid, url if !valid?(url)
      res = pattern.match(url)
      pid = res[:pid]
      md = /(?<pid>\w{5,})(s|l|b|m|t)$/.match(pid)
      pid = md[:pid] if md else pid
      ptype = res[:ptype] || ".jpg"


      raise Thornbed::NotValid, url if not pid

      {
        url: "http://i.imgur.com/#{pid}#{ptype}",
        type: "photo",
        provider_name: provider_name,
        provider_url: "http://imgur.com",
        thumbnail_url: "http://i.imgur.com/#{pid}s#{ptype}",
        version: "1.0",
        page: "http://imgur.com/#{pid}",
        width: nil,
        height: nil
      }
    end
  end
end
