require_relative 'scraper'

module VbulletinScraper
    module V4
        class PostScraper < Scraper
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
                postContent = get_items_by_selector('.content blockquote')
                if postContent != nil
                    postContentNoQuotes = Nokogiri::HTML.fragment(postContent.inner_html)
                    postContentNoQuotes.search('div').remove
                    postContentNoQuotes.search('comment()').remove
                    return get_raw_text(postContentNoQuotes.to_s)
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
                    begin
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
                    rescue ArgumentError
                        submitDateTime = nil
                    end
                    return submitDateTime
                end
                return nil
            end

            def get_quotes
                quotes = get_items_by_selector('.bbcode_container')
                if quotes != nil
                    return get_items_by_selector('.bbcode_container')
                else
                    return []
                end
            end

            def get_post_permalink
                permalink = get_item_by_selector_with_attribute('.postcounter', 'href')
                if permalink != nil
                    return get_raw_text(permalink)
                end
                return ''
            end
        end
    end
end