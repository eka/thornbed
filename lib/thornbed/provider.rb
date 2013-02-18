require "thornbed/errors"
require "thornbed/version"

module Thornbed
  module Providers
    class Provider
      @providers = []
      USER_AGENT = "Thornbed/#{Thornbed::VERSION}"

      class << self
        attr_reader :providers
      end

      def self.inherited(subclass)
        providers << subclass
      end

      def pattern
        raise NotImplementedError,
          'Subclasses must implement a pattern method'
      end

      def valid?(url)
        !!pattern.match(url)
      end

      def provider_name
        self.class.to_s.split('::')[-1]
      end

      def get(url)
        raise NotImplementedError, "Subclasses must implement a get method."
      end
    end

    def self.get(url)
      provider = Provider.providers.detect { |p| p.new.valid?(url) }
      raise Thornbed::NotFound, url if provider.nil?
      provider.new.get(url)
    end
  end
end
