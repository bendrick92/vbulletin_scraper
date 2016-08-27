module VbulletinScraper
    module V4
        class Post
            attr_accessor :id
            attr_accessor :vbulletin_post_id
            attr_accessor :author
            attr_accessor :content
            attr_accessor :submit_date
            
            attr_accessor :topic

            def initialize
                self.id = 0
                self.vbulletin_post_id = 0
                self.author = ""
                self.content = ""
                self.submit_date = nil

                self.topic = nil
            end
        end
    end
end