module VbulletinScraper
    class Configuration
        attr_accessor :post_count

        def initialize
            @post_count = 10
        end
    end
end