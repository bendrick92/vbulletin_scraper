require_relative 'vbulletin_scraper/version'
require_relative 'configuration'

module VbulletinScraper
    class << self
        attr_writer :configuration
    end

    def self.configuration
        @configuration ||= Configuration.new
    end

    def self.configure
        yield(configuration)
    end

    def self.reset
        @configuration = Configuration.new
    end
end
