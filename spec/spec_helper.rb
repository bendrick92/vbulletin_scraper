require 'bundler/setup'
require 'simplecov'
require 'codeclimate-test-reporter'
Bundler.setup

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
])
SimpleCov.start

require_relative '../lib/vbulletin_scraper'
