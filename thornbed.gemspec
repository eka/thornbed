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
  gem.summary       = %q{Thornbed provides a single interface to get embeddable content from many sites, even sites with no OEmbed support.}
  gem.homepage      = "https://github.com/eka/thornbed/"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "ruby-oembed", ">= 0.8.11"
  gem.add_runtime_dependency "httparty", ">= 0.13.3"
  gem.add_development_dependency "minitest", "~> 5.4.3"
  gem.add_development_dependency "guard-minitest", "~> 2.3.2"
  gem.add_development_dependency "rb-fsevent", "~> 0.9.4"
  gem.add_development_dependency "terminal-notifier-guard", "~> 1.6.4"
  gem.add_development_dependency "fakeweb", "~> 1.3.0"
  gem.add_development_dependency "thor", "~> 0.19.1"
end
