require "oembed"
require "thornbed/version"
require "thornbed/provider"
require "thornbed/providers"
require "thornbed/errors"


OEmbed::Providers.register_all

module Thornbed
  def self.get(url)
    res = OEmbed::Providers.get(url)
    res.fields
  end
end