require_relative '../spec_helper'

describe VbulletinScraper::V4::PostScraper do
    post_scraper_post_html = VbulletinScraper::V4::PostScraper.new("<div class='posthead'><span class='postdate old'><span class='date'>04-30-2016,&nbsp;<span class='time'>07:26 AM</span></span></span><span class='nodecontrols'><a name='post1085225' href='#' class='postcounter'>#1</a><a id='postcount1085225'' name='1'></a></span></div><div class='postdetails'><a class='username' href='#'><strong>ST2Focus</span>&nbsp;<img src='/img/smod.png'></strong></a></div><div class='postbody'><div class='content'><blockquote class='postcontent'>This is a test</blockquote></div></div>")
    post_scraper_post_html_with_quotes = VbulletinScraper::V4::PostScraper.new("<div class='posthead'><span class='postdate old'><span class='date'>04-30-2016,&nbsp;<span class='time'>07:26 AM</span></span></span><span class='nodecontrols'><a name='post1085225' href='#' class='postcounter'>#1</a><a id='postcount1085225'' name='1'></a></span></div><div class='postdetails'><a class='username' href='#'><strong>ST2Focus</span>&nbsp;<img src='/img/smod.png'></strong></a></div><div class='postbody'><div class='content'><blockquote class='postcontent'><div class='bbcode_container'><div class='bbcode_postedby'>Originally Posted by <strong>Ben</strong><a href='http://www.google.com'>..</a></div><div class='message'>This is a test</div></div>This is a test with a <a href='#'>link</a> too!</blockquote></div></div>")
    post_scraper_invalid_input = VbulletinScraper::V4::PostScraper.new("<div class='test'></div>")

    describe "#initialize" do
        context "given an input url" do
            it "instantiates successfully" do
                expect(post_scraper_post_html).to_not be_nil
            end
        end
        context "given no input" do
            it "throws an error" do
                expect { VbulletinScraper::V4::PostScraper.new() }.to raise_error(ArgumentError)
            end
        end
    end

    describe "#get_vbulletin_post_id" do
        context "using valid data" do
            it "returns vbulletin-specific id" do
                expect(post_scraper_post_html.get_vbulletin_post_id).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(post_scraper_invalid_input.get_vbulletin_post_id).to eql("")
            end
        end
    end

    describe "#get_post_author" do
        context "using valid data" do
            it "returns post author" do
                expect(post_scraper_post_html.get_post_author).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(post_scraper_invalid_input.get_post_author).to eql("")
            end
        end
    end

    describe "#get_post_content_raw" do
        context "using valid data" do
            it "returns post content" do
                expect(post_scraper_post_html.get_post_content_raw).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(post_scraper_invalid_input.get_post_content_raw).to eql("")
            end
        end
    end

    describe "#get_post_content" do
        context "using valid data" do
            it "returns post content" do
                expect(post_scraper_post_html.get_post_content).not_to eql("")
            end
        end
        context "using valid data with quotes" do
            it "returns post content without quotes" do
                expect(post_scraper_post_html_with_quotes.get_post_content).to eql("This is a test with a <a href=\"#\">link</a> too!")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(post_scraper_invalid_input.get_post_content).to eql("")
            end
        end
    end

    describe "#get_post_submit_datetime" do
        context "using valid data" do
            it "returns post datetime" do
                expect(post_scraper_post_html.get_post_submit_datetime).not_to be_nil
            end
        end
        context "using invalid data" do
            it "returns nil" do
                expect(post_scraper_invalid_input.get_post_submit_datetime).to be_nil
            end
        end
    end

    describe "#get_quotes" do
        context "using valid data with quote objects" do
            it "returns array of quotes" do
                expect(post_scraper_post_html_with_quotes.get_quotes).not_to be_empty
            end
        end
        context "using valid data without quote objects" do
            it "returns empty array" do
                expect(post_scraper_post_html.get_quotes).to be_empty
            end
        end
        context "using invalid data" do
            it "returns empty array" do
                expect(post_scraper_invalid_input.get_quotes).to be_empty
            end
        end
    end

    describe "#get_post_permalink" do
        context "using valid data" do
            it "returns post permalink" do
                expect(post_scraper_post_html.get_post_permalink).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(post_scraper_invalid_input.get_post_permalink).to eql("")
            end
        end
    end
end