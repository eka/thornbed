require "pathname"

Dir["lib/thornbed/providers/*.rb"].each do |name|
  basename = Pathname.new(name).basename.to_s
  require "thornbed/providers/#{basename}"
end