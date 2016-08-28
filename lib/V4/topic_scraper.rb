require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

module VbulletinScraper
    module V4
        class TopicScraper
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

            def get_current_page_number
                if is_valid_vbulletin
                    pageNumber = get_item_by_selector('#pagination_top a.popupctrl')				
                    if pageNumber != nil
                        pageNumber = pageNumber.text.gsub('Page', '').gsub(' ', '').split('of').first
                        return get_int(get_raw_text(pageNumber))
                    else
                        return 1
                    end
                end
                return 0
            end
                
            def get_total_page_count
                if is_valid_vbulletin
                    pageCount = get_item_by_selector('#pagination_top a.popupctrl')
                    if pageCount != nil
                        pageCount = pageCount.text().gsub('Page', '').gsub(' ', '').split('of').last
                        return get_int(get_raw_text(pageCount))
                    else
                        return 1
                    end
                end
                return ''
            end
                
            def get_vbulletin_topic_id
                vbulletinTopicId = get_item_by_selector_with_attribute('input[name="searchthreadid"]', 'value')
                if vbulletinTopicId != nil
                    return get_raw_text(vbulletinTopicId)
                end
                return ''
            end
                
            def get_topic_url
                topicUrl = get_item_by_selector_with_attribute('a[rel="start"]', 'href')
                if topicUrl == nil
                    topicUrl = get_item_by_selector_with_attribute('link[rel="canonical"]', 'href')
                end
                if topicUrl != nil && topicUrl != ''
                    return get_raw_text(topicUrl)
                else
                    return ''
                end
            end
                
            def get_topic_title
                topicTitle = get_item_by_selector('.threadtitle a')
                if topicTitle != nil
                    return get_raw_text(topicTitle.text)
                else
                    return ''
                end
            end

            def get_posts
                posts = get_items_by_selector('.postcontainer')
                if posts != nil
                    return get_items_by_selector('.postcontainer')
                else
                    return []
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