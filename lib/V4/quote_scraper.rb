require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

module VbulletinScraper
    module V4
        class QuoteScraper
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

            def get_quote_author
                quoteAuthor = get_item_by_selector('.bbcode_postedby strong')
                if quoteAuthor != nil
                    return get_raw_text(quoteAuthor.text)
                end
                return ''
            end

            def get_quote_content
                quoteContent = get_item_by_selector('.message')
                if quoteContent != nil
                    return get_raw_text(quoteContent.text)
                end
                return ''
            end

            def get_item_by_selector(selector)
                if @data != nil
                    if @data.at_css(selector)
                        return @data.at_css(selector)
                    end
                end
                return nil
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
        end
    end
end