require_relative 'scraper'

module VbulletinScraper
    module V4
        class ForumScraper < Scraper
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
        end
    end
end