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
    attr_reader :tag, :content, :tag_type, :opt
    
    def initialize(tag, content = [], tag_type = 'double', opt = {})
        @tag = tag
        @content = content
        @opt = opt
        @tag_type = tag_type
    end

    def add_content(*new_content)
        @content = [@content] unless @content.is_a?(Array)
        @content += new_content.flatten(1)
    end

    def to_s(wrap_quotes = true)
        attrs = format_attributes
        if @tag_type == 'simple'
            result = "<#{@tag}#{attrs} />"
        elsif @tag_type == 'double'
            result = "<#{@tag}#{attrs}>"

            if content.is_a?(Text)
                result += @content.to_s
            elsif @content.is_a?(String)
                result += @content.empty? ? "\\n" : @content
            elsif @content.is_a?(Array)
                result += "\\n"
                @content.each do |item|
                    if item.is_a?(Elem)
                        result += item.to_s(false) + "\\n"
                    else
                        result += item.to_s + "\\n"
                    end
                end
            else
                result += "\\n"
            end
            result += "</#{@tag}>"
        end
        wrap_quotes ? "\"#{result}\"" : result    
    end    
    private

    def format_attributes
        if @opt.empty?
            return ""
        end
        " " + @opt.map { |key, value| "#{key}='#{value}'" }.join(" ")
    end 
end

if $PROGRAM_NAME == __FILE__
    #test 1
    my_text = Text.new("hello world")
    my_tag = Elem.new("h1", my_text)
    img = Elem.new('img', '', 'simple', {'src' => 'http://i.imgur.com/pfp3T.jpg'})
    puts img
    puts my_tag.to_s
    puts
    #simple element with text (not array)
    h1 = Elem.new('h1', Text.new('"Oh no, not again!"'))
    puts h1
    puts

    h2 = Elem.new('h2', 'Hello')
    puts h2.to_s
    puts

    p_tag = Elem.new('p', 'This is raw HTML.')
    puts p_tag.to_s(false)
    puts

    #empty body
    body = Elem.new('body')
    puts body
    puts

    #elements with attributes (simple tag)
    img = Elem.new('img', '', 'simple', {'src' => 'https://i.imgur.com/pfpeT.jpg'})
    puts img
    puts

    html = Elem.new('html')
    head = Elem.new('head')
    body2 = Elem.new('body')
    title = Elem.new('title', Text.new('"Hello ground!"'))
    h1_2 = Elem.new('h1', Text.new('"Oh no, not again!"'))
    img2 = Elem.new('img', '', 'simple', {'src' => 'https://i.imgur.com/pfp3T.jpg'})

    head.add_content(title)
    body2.add_content(h1_2, img2)
    html.add_content(head, body2)
    puts html
end