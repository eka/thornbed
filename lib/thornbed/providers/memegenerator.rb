require "uri"
require "thornbed"

module Thornbed::Providers
  class Memegenerator < Thornbed::Providers::Provider
    attr_accessor :pattern

    def initialize
      self.pattern = /^http(s)?:\/\/(cdn\.)?memegenerator\.net\/instance(s)?\/(\d+x\/)?\d+(\.jpg)?(\?[\w\W]*)?$/
    end

    def get(url)
      raise Thornbed::NotValid, url if !valid?(url)
      url = URI.parse(url)
      ptype = "jpg"
      pic_id = /(\d+x\/)?\d+(\.jpg)?(\?[\w\W]*)?$/.match(url.path)
      {
        url: "http://cdn.memegenerator.net/instances/400x/#{pic_id}.#{ptype}",
        type: "photo",
        provider_name: provider_name,
        provider_url: "http://memegenerator.com",
        thumbnail_url: "http://cdn.memegenerator.net/instances/100x/#{pic_id}.#{ptype}",
        version: "1.0",
        page: "http://memegenerator.net/instance/#{pic_id}",
        width: nil,
        height: nil
      }
    end
  end
end
