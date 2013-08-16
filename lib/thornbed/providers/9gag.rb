require "uri"
require "thornbed"

module Thornbed::Providers
  class NineGag < Thornbed::Providers::Provider
    attr_accessor :pattern

    def initialize
      self.pattern = /^http(s)?:\/\/(\w+\.)?(9gag\.com\/|d24w6bsrhbeh9d\.cloudfront\.net\/photo\/)(gag\/|fast#)?(\d+)(\?[\w=]+)?(_\d+b\.jpg)?$/
    end

    def get(url)
      raise Thornbed::NotValid, url if !valid?(url)
      url = URI.parse(url)
      ptype = "jpg"

      pic_id = url.path == '/fast' ? url.fragment : /(\d+)/.match(url.path)[0]

      {
        "url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/#{pic_id}_700b.#{ptype}",
        "type" => "photo",
        "provider_name" => provider_name,
        "provider_url" => "http://9gag.com",
        "thumbnail_url" => "http://d24w6bsrhbeh9d.cloudfront.net/photo/#{pic_id}_fbthumbnail.#{ptype}",
        "version" => "1.0",
        "page" => "http://9gag.com/gag/#{pic_id}",
        "width" => nil,
        "height" => nil
      }
    end
  end
end
