# VbulletinScraper

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/vbulletin_scraper`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vbulletin_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vbulletin_scraper

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vbulletin_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

