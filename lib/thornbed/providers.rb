require "pathname"
providers = File.join(File.dirname(__FILE__), 'providers')
Dir["#{providers}/*.rb"].each do |name|
  basename = Pathname.new(name).basename.to_s
  require "thornbed/providers/#{basename}"
end