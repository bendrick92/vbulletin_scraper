require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

module VbulletinScraper
    module V4
        class Scraper
            attr_accessor :data

            def initialize(input)
                @data = nil
                if input.start_with? "http" || "www"
                    @data = Nokogiri::HTML(open(input, :allow_redirections => :all))
                    @data.encoding = "UTF-8"
                else
                    @data = Nokogiri::HTML(input)
                    @data.encoding = "UTF-8"
                end
            end

            def get_item_by_selector(selector)
                if !@data.nil?
                    if @data.at_css(selector)
                        return @data.at_css(selector)
                    end
                end
                return nil
            end

            def get_items_by_selector(selector)
                if !@data.nil?
                    if @data.css(selector)
                        return @data.css(selector)
                    end
                end
            end
                
            def get_item_by_selector_with_attribute(selector, attribute)
                if !@data.nil?
                    if @data.at_css(selector)
                        return @data.at_css(selector)[attribute]
                    end
                end
                return nil
            end
                
            def get_raw_text(input)
                if !input.nil?
                    return input.strip.gsub(/\u00a0/, ' ')
                else
                    return nil
                end
            end
                
            def get_int(input)
                if !input.nil?
                    if input != ''
                        begin
                            return input.to_i
                        end
                    end
                end        
                return 0
            end
        end
    end
end