#!/usr/bin/env -S ruby -w

class Text 
    attr_reader :content
    def initialize(content)
        @content = content
    end
    def to_s
        @content 
    end
end

class Elem
    def initialize(tag, content = [], tag_type = 'double', opt = {})
        @tag = tag
        @content = content
        @opt = opt
        @tag_type = tag_type
    end

    def add_content(*new_content)
        @content = unless @content.is_a?(Array)
            [@content]
        @content += new_content.flatten(1)
    end
    
    def to_s
        attrs = format_attributes
        if @tag_type == 'simple'
            result = "<#{@tag}#{attrs} />"
            return result
        elsif @tag_type == 'double'
            # result = "<#{@tag}>#{@content.to_s}>" #i may have to change this
            result = "<#{@tag}>#{attrs}"
            if @content.is_a?(Text)
                result += @content.to_s

            elsif @content.is_a?(String)
                if @content.empty?
                    result += "\n"
                else
                    result += @content
                end
            
            elsif @content.is_a?(Array)
                result += "\n"
                @content.each do |item|
                    result += item.to_s + "\n"
                end
            else
                result += "\n"
            end
            result += "</#{@tag}>"
            return result
        end
    end

    def format_attributes
        if @opt.empty?
            return ""
        end
        " " + @opt.map { |key, value| "#{key}='#{value}'" }.join(" ")
    end 
end

if $PROGRAM_NAME == __FILE__
    my_text = Text.new("hello world")
    my_tag = Elem.new("h1", my_text)
    img = Elem.new('img', '', 'simple', {'src' => 'http://i.imgur.com/pfp3T.jpg'})
    puts img
    puts my_tag.to_s 
end