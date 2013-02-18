require "uri"
require "thornbed"
require "httparty"


module Thornbed::Providers
  class Imgur < Thornbed::Providers::Provider
    attr_accessor :pattern

    def initialize
      self.pattern = /^https?:\/\/(www\.|i\.)?imgur\.com\/(gallery\/)?(?<pid>\w{5,})(?<ptype>\.gif|\.jpg|\.jpeg|\.png)?(\?full)?$/
    end

    def get(url)
      raise Thornbed::NotValid, url if !valid?(url)

      # imgur pic_id is ambiguous since the chars for thumb etc... can be part of the id
      # so we check the embed page
      # first get the pseudo id
      md = pattern.match(url)
      pid = md[:pid]
      # TODO: improve this code
      if pid.length > 5
        pid = pid.gsub(/(h|m|l|s)?$/, '')
      end
      raise Thornbed::NotValid, url if not pid

      res = HTTParty.get("http://imgur.com/#{pid}?tags", headers: {"User-Agent" => USER_AGENT})

      # now get the real pid and ptype from that page
      md = /id\=\"nondirect\"[ ]+value\=\"http:\/\/imgur.com\/(?<pid>\w+)/.match(res.body)
      pid = md[:pid]

      raise Thornbed::NotValid, url if not pid

      md = /id\=\"direct\"[ ]+value\=\"http:\/\/i.imgur.com\/\w+(?<ptype>\.jpg|\.jpeg|\.png|\.gif)/.match(res.body)
      ptype = md[:ptype] || ".jpg"

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
