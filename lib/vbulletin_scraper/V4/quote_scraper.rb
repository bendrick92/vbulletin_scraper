require_relative 'scraper'

module VbulletinScraper
    module V4
        class QuoteScraper < Scraper
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
        end
    end
end