require "uri"
require "thornbed"

module Thornbed::Providers
  class Memecrunch < Thornbed::Providers::Provider
    attr_accessor :pattern

    def initialize
      self.pattern = /^http(s)?:\/\/memecrunch.com\/meme\/\w+\/[\w-]+(\/image.png)?(\?w=\d+)?$/
    end

    def get(url)
      raise Thornbed::NotValid, url if !valid?(url)
      url = URI.parse(url)

      res = /([A-Z]{4,})\/([\w-]+)/.match(url.path)
      pic_id = res[1]
      slug = res[2]

      {
        url: "http://memecrunch.com/meme/#{pic_id}/#{slug}/image.png",
        type: "photo",
        provider_name: provider_name,
        provider_url: "http://memecrunch.com",
        thumbnail_url: "http://memecrunch.com/meme/#{pic_id}/#{slug}/image.png?w=75",
        version: "1.0",
        page: "http://memecrunch.com/meme/#{pic_id}/#{slug}/",
        width: nil,
        height: nil
      }
    end
  end
end
