require_relative '../spec_helper'
require_relative '../../lib/V4/quote_scraper'

describe VbulletinScraper::V4::QuoteScraper do
    quote_scraper_quote_html = VbulletinScraper::V4::QuoteScraper.new("<div class='bbcode_container'><div class='bbcode_postedby'>Originally Posted by <strong>Ben</strong><a href='http://www.google.com'>..</a></div><div class='message'>This is a test</div></div>")
    quote_scraper_invalid_input = VbulletinScraper::V4::QuoteScraper.new("<div class='test'></div>")

    describe "#initialize" do
        context "given an input url" do
            it "instantiates successfully" do
                expect(quote_scraper_quote_html).to_not be_nil
            end
        end
        context "given no input" do
            it "throws an error" do
                expect { VbulletinScraper::V4::QuoteScraper.new() }.to raise_error(ArgumentError)
            end
        end
    end

    describe "#get_quote_author" do
        context "using valid data" do
            it "returns quote author" do
                expect(quote_scraper_quote_html.get_quote_author).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(quote_scraper_invalid_input.get_quote_author).to eql("")
            end
        end
    end

    describe "#get_quote_content" do
        context "using valid data" do
            it "returns quote content" do
                expect(quote_scraper_quote_html.get_quote_content).not_to eql("")
            end
        end
        context "using invalid data" do
            it "returns empty string" do
                expect(quote_scraper_invalid_input.get_quote_content).to eql("")
            end
        end
    end
end