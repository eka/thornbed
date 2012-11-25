require "uri"
require "thornbed"

module Thornbed::Providers
  class Memegenerator < Thornbed::Providers::Provider
    attr_reader :type, :provider_url

    def initialize
      @pattern = /^http(s)?:\/\/(cdn\.)?memegenerator\.net\/instance(s)?\/(\d+x\/)?\d+(\.jpg)?(\?[\w\W]*)?$/
      @type = "photo"
      @provider_url = "http://memegenerator.com"
    end

    def get(url)
      raise Thornbed::NotValid, url if !self.valid?(url)
      url = URI.parse(url)
      ptype = "jpg"
      pic_id = /(\d+x\/)?\d+(\.jpg)?(\?[\w\W]*)?$/.match(url.path)
      {
        url: "http://cdn.memegenerator.net/instances/400x/#{pic_id}.#{ptype}",
        type: "#{type}",
        provider_name: self.provider_name,
        provider_url: provider_url,
        thumbnail_url: "http://cdn.memegenerator.net/instances/100x/#{pic_id}.#{ptype}",
        version: "1.0",
        page: "http://memegenerator.net/instance/#{pic_id}",
        width: nil,
        height: nil
      }
    end
  end
end
