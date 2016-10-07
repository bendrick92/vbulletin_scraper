require_relative '../spec_helper'

describe VbulletinScraper::V4::TopicScraper do
    topic_scraper_multiple_paged_thread = VbulletinScraper::V4::TopicScraper.new("http://www.focusst.org/forum/focus-st-news/50228-new-ford-fiesta-st-focus-st-development-under-way.html")
    topic_scraper_single_paged_thread = VbulletinScraper::V4::TopicScraper.new("http://www.focusst.org/forum/focus-st-news/49170-april-2016-focus-st-month-contest-winner-thunderlope.html")
    topic_scraper_invalid_input = VbulletinScraper::V4::TopicScraper.new("http://www.google.com")

    describe "#initialize" do
        context "given an input url" do
            it "instantiates successfully" do
                expect(topic_scraper_single_paged_thread).to_not be_nil
            end
        end
        context "given no input" do
            it "throws an error" do
                expect { VbulletinScraper::V4::TopicScraper.new() }.to raise_error(ArgumentError)
            end
        end
    end
    
    describe "#is_valid_vbulletin" do
        context "given valid data" do
            it "returns true" do
                expect(topic_scraper_single_paged_thread.is_valid_vbulletin).to be true
            end
        end
        context "given invalid data" do
            it "returns false" do
                expect(topic_scraper_invalid_input.is_valid_vbulletin).to be false
            end
        end
    end

    describe "#get_vbulletin_version" do
        context "using valid data" do
            it "returns forum version" do
                expect(topic_scraper_single_paged_thread.get_vbulletin_version).to eql("4.2.0")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(topic_scraper_invalid_input.get_vbulletin_version).to eql("")
            end
        end
    end

    describe "#get_current_page_number" do
        context "using valid data" do
            context "single page thread" do
                it "returns 1" do
                    expect(topic_scraper_single_paged_thread.get_current_page_number).to eql(1)
                end
            end
            context "multi page thread" do
                it "returns page number >= 1" do
                    expect(topic_scraper_multiple_paged_thread.get_current_page_number).to be >= 1
                end
            end
        end
        context "using invalid data" do
            it "returns 0" do
                expect(topic_scraper_invalid_input.get_current_page_number).to eql(0)
            end
        end
    end

    describe "#get_total_page_count" do
        context "using valid data" do
            context "single page thread"do
                it "returns 1" do
                    expect(topic_scraper_single_paged_thread.get_total_page_count).to eql(1)
                end
            end
            context "multi page thread" do
                it "returns page count > 1" do
                    expect(topic_scraper_multiple_paged_thread.get_total_page_count).to be > 1
                end
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(topic_scraper_invalid_input.get_total_page_count).to eql("")
            end
        end
    end

    describe "#get_vbulletin_topic_id" do
        context "using valid data" do
            it "returns vbulletin topic id" do
                expect(topic_scraper_single_paged_thread.get_vbulletin_topic_id).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(topic_scraper_invalid_input.get_vbulletin_topic_id).to eql("")
            end
        end
    end

    describe "#get_topic_url" do
        context "using valid data" do
            it "returns topic url" do
                expect(topic_scraper_single_paged_thread.get_topic_url).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(topic_scraper_invalid_input.get_topic_url).to eql("")
            end
        end
    end

    describe "#get_topic_title" do
        context "using valid data" do
            it "returns topic title" do
                expect(topic_scraper_single_paged_thread.get_topic_title).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(topic_scraper_invalid_input.get_topic_title).to eql("")
            end
        end
    end

    describe "#get_posts" do
        context "using valid data" do
            it "returns array of posts" do
                expect(topic_scraper_single_paged_thread.get_posts).not_to be_empty
            end
        end
        context "using invalid data" do
            it "returns empty array" do
                expect(topic_scraper_invalid_input.get_posts).to be_empty
            end
        end
    end
end