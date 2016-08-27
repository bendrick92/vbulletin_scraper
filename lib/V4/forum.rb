module VbulletinScraper
    module V4
        class Forum            
            attr_accessor :id
            attr_accessor :is_vbulletin
            attr_accessor :vbulletin_version
            attr_accessor :title
            attr_accessor :url

            def initialize
                self.id = 0
                self.is_vbulletin = false
                self.vbulletin_version = ""
                self.title = ""
                self.url = ""
            end
        end
    end
end