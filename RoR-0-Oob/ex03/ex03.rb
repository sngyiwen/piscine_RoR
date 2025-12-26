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

    def to_s
        attrs = format_attributes
        if @tag_type == 'simple'
            result = "<#{@tag}#{attrs} />"
        elsif @tag_type == 'double'
            # result = "<#{@tag}>#{@content.to_s}>" #i may have to change this
            if @content.is_a?(Text)
                result = "<#{@tag}>#{@content.to_s}"
            end
            # elsif @content.is_a?(Array)
           
            # elsif @content.is_a?(String)
            result += "</#{@tag}>"
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