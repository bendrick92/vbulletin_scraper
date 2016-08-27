require_relative 'forum_scraper'
require_relative 'topic_scraper'
require_relative 'post_scraper'

module VbulletinScraper
    module V4
        class Scraper
            attr_accessor :url
            attr_accessor :forum
            attr_accessor :topic
            attr_accessor :posts

            def initialize(url)
                @url = url
                
                forumScraper = VbulletinScraper::V4::ForumScraper.new(@url)
                @forum = forumScraper.get_forum_object

                topicScraper = VbulletinScraper::V4::TopicScraper.new(@url)
                @topic = topicScraper.get_topic_object

                @posts = []
                load_latest_posts
            end

            def load_latest_posts(count = VbulletinScraper.configuration.post_count)
                stop = false
                currPage = 9999
                posts = []

                until stop do
                    currPageUrl = @url + '?page=' + currPage.to_s
                    currPageScraper = VbulletinScraper::V4::TopicScraper.new(currPageUrl)
                    currPagePosts = currPageScraper.get_posts

                    currPagePosts.each do |postContent|
                        postScraper = VbulletinScraper::V4::PostScraper.new(postContent.to_s)

                        post = postScraper.get_post_object
                        posts << post
                        if posts.length >= count
                            stop = true
                        end
                    end

                    currPageNumber = currPageScraper.get_current_page_number

                    if currPageNumber > 1
                        currPageNumber -= 1
                    else
                        stop = true
                    end
                end

                posts.sort! { |a,b| b.submit_date <=> a.submit_date }
                
                @posts = posts
            end
        end
    end
end