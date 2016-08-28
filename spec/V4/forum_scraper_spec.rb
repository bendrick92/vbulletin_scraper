require_relative '../spec_helper'
require_relative '../../lib/V4/forum_scraper'

describe VbulletinScraper::V4::ForumScraper do
    forum_scraper_multiple_paged_thread = VbulletinScraper::V4::ForumScraper.new("http://www.focusst.org/forum/focus-st-news/50228-new-ford-fiesta-st-focus-st-development-under-way.html")
    forum_scraper_single_paged_thread = VbulletinScraper::V4::ForumScraper.new("http://www.focusst.org/forum/focus-st-news/49170-april-2016-focus-st-month-contest-winner-thunderlope.html")
    forum_scraper_invalid_input = VbulletinScraper::V4::ForumScraper.new("http://www.google.com")

    describe "#initialize" do
        context "given an input url" do
            it "instantiates successfully" do
                expect(forum_scraper_single_paged_thread).to_not be_nil
            end
        end
        context "given no input" do
            it "throws an error" do
                expect { VbulletinScraper::V4::ForumScraper.new() }.to raise_error(ArgumentError)
            end
        end
    end

    describe "#is_valid_vbulletin" do
        context "given valid data" do
            it "returns true" do
                expect(forum_scraper_single_paged_thread.is_valid_vbulletin).to be true
            end
        end
        context "given invalid data" do
            it "returns false" do
                expect(forum_scraper_invalid_input.is_valid_vbulletin).to be false
            end
        end
    end

    describe "#get_vbulletin_version" do
        context "using valid data" do
            it "returns forum version" do
                expect(forum_scraper_single_paged_thread.get_vbulletin_version).to eql("4.2.0")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(forum_scraper_invalid_input.get_vbulletin_version).to eql("")
            end
        end
    end

    describe "#get_forum_url" do
        context "using valid data" do
            it "returns base forum url" do
                expect(forum_scraper_single_paged_thread.get_forum_url).to_not eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(forum_scraper_invalid_input.get_forum_url).to eql("")
            end
        end
    end

    describe "#get_forum_title" do
        context "using valid data" do
            it "returns title of forum" do
                expect(forum_scraper_single_paged_thread.get_forum_title).to_not eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(forum_scraper_invalid_input.get_forum_title).to eql("")
            end
        end
    end
end