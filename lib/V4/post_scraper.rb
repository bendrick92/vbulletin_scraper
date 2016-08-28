require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

module VbulletinScraper
    module V4
        class PostScraper
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
                
            def get_vbulletin_post_id
                vbulletinPostId = get_item_by_selector_with_attribute('.nodecontrols a', 'name')
                if vbulletinPostId != nil
                    return get_raw_text(vbulletinPostId.gsub('post', ''))
                end
                return ''
            end
                
            def get_post_author
                postAuthor = get_item_by_selector('.username')
                if postAuthor != nil
                    return get_raw_text(postAuthor.text)
                end
                return ''
            end
                
            def get_post_content_raw
                postContent = get_item_by_selector('.content blockquote')
                if postContent != nil
                    return postContent.to_s
                end
                return ''
            end
                
            def get_post_content
                postContent = get_item_by_selector('.content blockquote')
                if postContent != nil
                    return get_raw_text(postContent.text)
                end
                return ''
            end
                
            def get_post_submit_datetime
                dateFormat = '%m-%d-%Y'
                timeFormat = '%I:%M %P'
                dateTimeFormat = dateFormat + ', ' + timeFormat
                
                rawDateTimeString = get_item_by_selector('.date')
                if rawDateTimeString != nil
                    rawDateTimeString = get_raw_text(rawDateTimeString.text)
                    if rawDateTimeString.include? 'Yesterday'
                        rawDateTimeString = rawDateTimeString.gsub('Yesterday', '')
                        formattedDateTimeString = Date.yesterday.strftime(dateFormat) + rawDateTimeString
                        submitDateTime = DateTime.strptime(formattedDateTimeString, dateTimeFormat)
                    elsif rawDateTimeString.include? 'Today'
                        rawDateTimeString = rawDateTimeString.gsub('Today', '')
                        formattedDateTimeString = Date.today.strftime(dateFormat) + rawDateTimeString
                        submitDateTime = DateTime.strptime(formattedDateTimeString, dateTimeFormat)
                    else
                        submitDateTime = DateTime.strptime(rawDateTimeString, dateTimeFormat)
                    end
                    return submitDateTime
                end
                return nil
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