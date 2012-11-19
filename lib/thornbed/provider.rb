module Thornbed
  module Providers
    class Provider
      @providers = []

      class << self
        attr_reader :providers
      end

      def self.inherited(subclass)
        @providers << subclass
      end

      def valid?(url)
        !!@pattern.match(url)
      end

      def provider_name
        self.class.to_s.split('::')[-1]
      end
    end

    def self.get(url)
      providers = Thornbed::Providers::Provider.providers
      provider = providers.detect { |p| p.new.valid?(url) }
      raise Thornbed::Error::NotFound if provider.nil?
      provider.new.get(url)
    end
  end
end