# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vbulletin_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "vbulletin_scraper"
  spec.version       = VbulletinScraper::VERSION
  spec.authors       = ["Ben Walters"]
  spec.email         = ["walters.benj@gmail.com"]

  spec.summary       = "This gem is designed to allow you to scrape compatible vBulletin forum threads for various data."
  spec.homepage      = "https://github.com/bendrick92/vbulletin_scraper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', '~> 1.6.8'
  spec.add_dependency 'open_uri_redirections'
  
  spec.add_development_dependency "simplecov", "~> 0.12"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.6"
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
