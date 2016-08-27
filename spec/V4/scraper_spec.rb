require_relative '../spec_helper'
require_relative '../../lib/V4/scraper'
require_relative '../../lib/V4/forum'
require_relative '../../lib/V4/topic'
require_relative '../../lib/V4/post'

describe VbulletinScraper::V4::Scraper do
    scraper_multiple_paged_thread = VbulletinScraper::V4::Scraper.new("http://www.focusst.org/forum/focus-st-news/50228-new-ford-fiesta-st-focus-st-development-under-way.html")
    scraper_single_paged_thread = VbulletinScraper::V4::Scraper.new("http://www.focusst.org/forum/focus-st-news/49170-april-2016-focus-st-month-contest-winner-thunderlope.html")
    scraper_invalid_input = VbulletinScraper::V4::Scraper.new("http://www.google.com")

    describe "#initialize" do
        context "given an input url" do
            it "instantiates successfully" do
                expect(scraper_single_paged_thread).to_not be_nil
            end
        end
        context "given no input" do
            it "throws an error" do
                expect { VbulletinScraper::V4::Scraper.new() }.to raise_error(ArgumentError)
            end
        end
    end

    describe "#load_latest_posts" do
        context "using valid data" do
            context "multiple paged topic" do
                context "given input of " + VbulletinScraper.configuration.post_count.to_s do
                    it "returns at least one post" do
                        scraper_multiple_paged_thread.load_latest_posts(VbulletinScraper.configuration.post_count)
                        expect(scraper_multiple_paged_thread.posts).to include(VbulletinScraper::V4::Post)
                    end
                end
                context "given input greater than " + VbulletinScraper.configuration.post_count.to_s do
                    it "returns at least one post" do
                        scraper_multiple_paged_thread.load_latest_posts(VbulletinScraper.configuration.post_count + 1)
                        expect(scraper_multiple_paged_thread.posts).to include(VbulletinScraper::V4::Post)
                    end
                end
                context "given no input" do
                    it "returns at least one post" do
                        scraper_multiple_paged_thread.load_latest_posts
                        expect(scraper_multiple_paged_thread.posts).to include(VbulletinScraper::V4::Post)
                    end
                end
            end
            context "single paged topic" do
                context "given input of " + VbulletinScraper.configuration.post_count.to_s do
                    it "returns at least one post" do
                        scraper_single_paged_thread.load_latest_posts(VbulletinScraper.configuration.post_count)
                        expect(scraper_single_paged_thread.posts).to include(VbulletinScraper::V4::Post)
                    end
                end
                context "given input greater than " + VbulletinScraper.configuration.post_count.to_s do
                    it "returns at least one post" do
                        scraper_single_paged_thread.load_latest_posts(VbulletinScraper.configuration.post_count + 1)
                        expect(scraper_single_paged_thread.posts).to include(VbulletinScraper::V4::Post)
                    end
                end
                context "given no input" do
                    it "returns at least one post" do
                        scraper_single_paged_thread.load_latest_posts
                        expect(scraper_single_paged_thread.posts).to include(VbulletinScraper::V4::Post)
                    end
                end
            end
        end
        context "using invalid data" do
            context "given input of " + VbulletinScraper.configuration.post_count.to_s do
                it "returns empty array" do
                    scraper_invalid_input.load_latest_posts(VbulletinScraper.configuration.post_count)
                    expect(scraper_invalid_input.posts).to match_array([])
                end
            end
            context "given input greater than " + VbulletinScraper.configuration.post_count.to_s do
                it "returns empty array" do
                    scraper_invalid_input.load_latest_posts(VbulletinScraper.configuration.post_count + 1)
                    expect(scraper_invalid_input.posts).to match_array([])
                end
            end
            context "given no input" do
                it "returns empty array" do
                    scraper_invalid_input.load_latest_posts
                    expect(scraper_invalid_input.posts).to match_array([])
                end
            end
        end
    end
end