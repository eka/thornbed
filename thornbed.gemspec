# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thornbed/version'

Gem::Specification.new do |gem|
  gem.name          = "thornbed"
  gem.version       = Thornbed::VERSION
  gem.authors       = ["Esteban (Eka) Feldman"]
  gem.email         = ["esteban.feldman@gmail.com"]
  gem.description   = %q{Thin OEmbed wrapper}
  gem.summary       = %q{Thin OEmbed wrapper}
  gem.homepage      = "https://github.com/eka/thornbed/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "ruby-oembed", "~> 0.8.7"
  gem.add_development_dependency "rspec", "~> 2.12.0"
  gem.add_development_dependency "guard-rspec", "~> 2.1.1"
  gem.add_development_dependency "rb-fsevent", "~> 0.9.2"
  gem.add_development_dependency "terminal-notifier-guard", "~> 1.5.3"
  gem.add_development_dependency "fakeweb", "~> 1.3.0"
end
