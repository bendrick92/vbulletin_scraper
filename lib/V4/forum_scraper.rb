require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require_relative 'forum'

module VbulletinScraper
    module V4
        class ForumScraper
            def initialize(input)
                @data = nil
                if input.start_with? "http" || "www"
                    @data = Nokogiri::HTML(open(input, :allow_redirections => :all))
                    @data.encoding = "UTF-8"
                else
                    @data = Nokogiri::HTML(input)
                    @data.encoding = "UTF-8"
                end
            end

            def get_forum_object
                forum = VbulletinScraper::V4::Forum.new

                if is_valid_vbulletin
                    forum.title = get_forum_title
                    forum.url = get_forum_url
                end

                return forum
            end

            def is_valid_vbulletin
                if get_vbulletin_version != ''
                    return true
                else
                    return false
                end
            end

            def get_vbulletin_version
                vbulletinVersion = get_item_by_selector_with_attribute('meta[name="generator"]', 'content')
                if vbulletinVersion != nil
                    return get_raw_text(vbulletinVersion.gsub('vBulletin', ''))
                end
                return ''
            end

            def get_forum_url
                pageUrl = get_item_by_selector_with_attribute('base', 'href')
                if pageUrl != nil
                    return get_raw_text(pageUrl)
                end
                return ''
            end

            def get_forum_title
                forumTitle = get_item_by_selector_with_attribute('#logo img', 'alt')
                if forumTitle == ''
                    forumTitle = get_item_by_selector_with_attribute('.logo img', 'title')
                end
                if forumTitle != nil
                    return get_raw_text(forumTitle)
                else
                    return ''
                end
            end

            def get_item_by_selector(selector)
                if @data != nil
                    if @data.at_css(selector)
                        return @data.at_css(selector)
                    end
                end
                return nil
            end

            def get_items_by_selector(selector)
                if @data != nil
                    if @data.css(selector)
                        return @data.css(selector)
                    end
                end
            end
                
            def get_item_by_selector_with_attribute(selector, attribute)
                if @data != nil
                    if @data.at_css(selector)
                        return @data.at_css(selector)[attribute]
                    end
                end
                return nil
            end
                
            def get_raw_text(input)
                if input != nil
                    return input.strip.gsub(/\u00a0/, ' ')
                else
                    return nil
                end
            end
                
            def get_int(input)
                if input != nil
                    if input != ''
                        begin
                            return input.to_i
                        end
                    end
                end        
                return 0
            end
        end
    end
end