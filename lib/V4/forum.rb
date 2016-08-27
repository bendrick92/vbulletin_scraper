module VbulletinScraper
    module V4
        class Forum            
            attr_accessor :id
            attr_accessor :title
            attr_accessor :url

            def initialize
                self.id = 0
                self.title = ""
                self.url = ""
            end
        end
    end
end