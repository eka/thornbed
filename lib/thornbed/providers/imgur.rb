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

      # from Alan Schaaf, Founder & CEO, Imgur.com
      # If the image ID is 6 or 8 characters then it's a thumbnail.
      if [6,8].include? pid.size
        pid = pid[0...-1]
      end

      raise Thornbed::NotValid, url if not pid

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
