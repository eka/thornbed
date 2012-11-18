module Thornbed
  class Error < StandardError
  end

  class NotFound < Thornbed::Error
    def to_s
      "No embeddable content at '#{super}'"
    end
  end

  class NotValid < Thornbed::Error
    def to_s
      "Not valid url for this provider"
    end
  end
end