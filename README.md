# VbulletinScraper

VbulletinScraper is a Ruby gem designed to parse compatible vBulletin forums, threads, and posts.  Currently only vBulletin forums v4.x are supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vbulletin_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vbulletin_scraper


## Available Functions

### Forums

    is_valid_vbulletin
    get_vbulletin_version
    get_forum_url
    get_forum_title
    
### Threads (Topics)

    is_valid_vbulletin
    get_vbulletin_version
    get_current_page_number
    get_total_page_count
    get_vbulletin_topic_id
    get_topic_url
    get_topic_title
    get_posts
    
### Posts

    get_vbulletin_post_id
    get_post_author
    get_post_content_raw
    get_post_content
    get_post_submit_datetime
    get_quotes
    get_post_permalink

### Quotes

    get_quote_author
    get_quote_content


## Usage

At the top of your Ruby file:

    require 'vbulletin_scraper'
    
Example usage:

    forumScraper = VbulletinScraper::V4::ForumScraper.new('http://someforum.com')
    isVbulletinForum = forumScraper.is_valid_vbulletin
    vbulletinVersion = forumScraper.get_vbulletin_version
    forumTitle = forumScraper.get_forum_title
    forumUrl = forumScraper.get_forum_url
    
    topicScraper = VbulletinScraper::V4::TopicScraper.new('http://someforum.com/forum/some-thread-section/1234-a-sample-thread')
    topicTitle = topicScraper.get_topic_title
    topicUrl = topicScraper.get_topic_url
    posts = topicScraper.get_posts
    
    posts.each do |post|
        postScraper = VbulletinScraper::V4::PostScraper.new(post.to_s)
        vbulletinPostId = postScraper.get_vbulletin_post_id
        postAuthor = postScraper.get_post_author
        postContent = postScraper.get_post_content
        postSubmitDate = postScraper.get_post_submit_datetime
        postPermalink = postScraper.get_post_permalink
        quotes = postScraper.get_quotes
        
        quotes.each do |quote|
            quoteScraper = VbulletinScraper::V4::QuoteScraper.new(quote.to_s)
            quoteAuthor = quoteScraper.get_quote_author
            quoteContent = quoteScraper.get_quote_content
        end
    end

To grab multiple pages of posts (starting with latest):

    url = 'http://someforum.com/forum/some-thread-section/1234-a-sample-thread'
    currPage = 9999
    postCounter = 0
    maxPosts = 10
    stop = false
    
    until stop do
        currPageUrl = url + '?page=' + currPage.to_s
        currPageScraper = VbulletinScraper::V4::TopicScraper.new(currPageUrl)
        currPagePosts = currPageScraper.get_posts
        
        currPagePosts.each do |post|
            postScraper = VbulletinScraper::V4::PostScraper.new(post.to_s)    
            
            # etc...
            
            postCounter += 1
            
            if postCounter >= maxPosts
                stop = true
            end
        end
        
        if currPage > 1
            currPage -= 1
        else
            stop = true
        end
    end


## Contributing

1. Fork it ( https://github.com/bendrick92/vbulletin_scraper/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

