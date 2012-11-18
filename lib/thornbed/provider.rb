module Thornbed
  module Providers
    class Provider
      def valid?(url)
        !!@pattern.match(url)
      end

      def provider_name
        self.class.to_s.split('::')[-1]
      end
    end
  end
end