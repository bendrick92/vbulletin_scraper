require_relative '../spec_helper'
require_relative '../../lib/V4/post_scraper'

describe VbulletinScraper::V4::PostScraper do
    post_scraper_post_html = VbulletinScraper::V4::PostScraper.new("<div class='posthead'><span class='postdate old'><span class='date'>04-30-2016,&nbsp;<span class='time'>07:26 AM</span></span></span><span class='nodecontrols'><a name='post1085225' href='#' class='postcounter'>#1</a><a id='postcount1085225'' name='1'></a></span></div><div class='postdetails'><a class='username' href='#'><strong>ST2Focus</span>&nbsp;<img src='/img/smod.png'></strong></a></div><div class='postbody'><div class='content'><blockquote class='postcontent'>This is a test</blockquote></div></div>")
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
end