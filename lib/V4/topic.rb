module VbulletinScraper
    module V4
        class Topic
            attr_accessor :id
            attr_accessor :title
            attr_accessor :url
            
            attr_accessor :posts

            def initialize
                self.id = 0
                self.title = ""
                self.url = ""

                self.posts = nil
            end
        end
    end
end