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

    def to_s
        attrs = format_attributes
        if @tag_type == 'simple'
            result = "<#{@tag}#{attrs} />"
        elsif @tag_type == 'double'
            result = "<#{@tag}#{attrs}>"

            if @content.is_a?(Text)
                result += @content.to_s
            elsif @content.is_a?(String)
                result += @content.empty? ? "\n" : @content
            elsif @content.is_a?(Array)
                result += "\n"
                @content.each do |item|
                    if item.is_a?(Elem)
                        result += item.to_s + "\n"
                    else
                        result += item.to_s + "\n"
                    end
                end
            else
                result += "\n"
            end
            result += "</#{@tag}>"
        end
    end    
    private

    def format_attributes
        if @opt.empty?
            return ""
        end
        " " + @opt.map { |key, value| "#{key}='#{value}'" }.join(" ")
    end 
end
class P < Elem
    def initialize(content = [], opt = {})
        super('P', content, 'double', opt)
    end
end

class Title < Elem
    def initialize(content = [], opt = {})
        super('Title', content, 'double', opt)
    end
end

class Head < Elem
    def initialize(content = [], opt = {})
        super('Head', content, 'double', opt)
    end
end

class Html < Elem
    def initialize(content = [], opt = {})
        super('Html', content, 'double', opt)
    end
end

class Body < Elem
    def initialize(content = [], opt = {})
        super('Body', content, 'double', opt)
    end
end

class Meta < Elem
    def initialize(content = [], opt = {})
        super('Meta', content, 'simple', opt)
    end
end

class Img < Elem
    def initialize(content = [], opt = {})
        super('Img', content, 'simple', opt)
    end
end

class Table < Elem
    def initialize(content = [], opt = {})
        super('Table', content, 'double', opt)
    end
end

class H1 < Elem
    def initialize(content = [], opt = {})
        super('H1', content, 'double', opt)
    end
end

class H2 < Elem
    def initialize(content = [], opt = {})
        super('H2', content, 'double', opt)
    end
end

class Div < Elem
    def initialize(content = [], opt = {})
        super('Div', content, 'double', opt)
    end
end

class Hr < Elem
    def initialize(content = [], opt = {})
        super('Hr', content, 'simple', opt)
    end
end

class Br < Elem
    def initialize(content = [], opt = {})
        super('Br', content, 'simple', opt)
    end
end

class Th < Elem
    def initialize(content = [], opt = {})
        super('Th', content, 'double', opt)
    end
end

class Tr < Elem
    def initialize(content = [], opt = {})
        super('Tr', content, 'double', opt)
    end
end

class Td < Elem
    def initialize(content = [], opt = {})
        super('Td', content, 'double', opt)
    end
end

class Ul < Elem
    def initialize(content = [], opt = {})
        super('Ul', content, 'double', opt)
    end
end

class Ol < Elem
    def initialize(content = [], opt = {})
        super('Ol', content, 'double', opt)
    end
end

class Li < Elem 
    def initialize(content = [], opt = {})
        super('Li', content, 'double', opt)
    end
end

class Span < Elem
    def initialize(content = [], opt = {})
        super('Span', content, 'double', opt)
    end
end
    
class Page
    def initialize(elem)
        @root = elem
    end

    def is_valid?
        result = validate(@root)
        if result
            puts "FILE IS OK"
        else
            puts "File is fuckeddd" #lolll

        end
        result
    end

    private
    
    def validate(elem)
        return false unless valid_element_type?(elem) 

        case elem
        when Html
            validate_html(elem)
        when Head 
            validate_head(elem)
        when Body
            validate_body(elem)
        when Title
            validate_title(elem)
        when H1, H2
            validate_heading(elem)
        # # when Li
        #     validate_li(elem)
        when Th, Td
            validate_th_td(elem)
        # when P
        #     validate_p(elem)
        # # when Span
        # #     validate_span(elem)
        when Ul, Ol
            validate_ul_ol(elem)
        when Tr
            validate_tr(elem)
        when Table
            validate_table(elem)
        when Div
            validate_div(elem)
        when Img
            validate_img(elem)
        when Text
            validate_text(elem)
        when Meta, Hr, Br
            true
        else
            false
        end
    end

    def validate_img(elem)
        puts "Currently evaluating a Img :"
        return false unless elem.opt.key?(:src)
        return false unless elem.opt[:src].is_a?(Text)

        puts "Img content is OK"
        true
    end
    def validate_heading(elem)
        return false unless elem.content.is_a?(Text)
        validate(elem.content)
    end

    def validate_th_td(elem)
        return false unless elem.content.is_a?(Text)
        validate(elem.content)
    end

    def validate_tr(elem)
        return false unless elem.content.is_a?(Array)
        return false if elem.content.empty?

        has_th = false
        has_td = false

        elem.content.each do |child|
            if child.is_a?(Th)
                has_th = true
            elsif child.is_a?(Td)
                has_td = true
            else 
                return false
            end
            return false unless validate(child)
        end
        return false if has_th && has_td
        true
    end

    def validate_table(elem)
        return false unless elem.content.is_a?(Array)

        elem.content.each do  |child|
            return false unless child.is_a?(Tr)
            return false unless validate(child)
        end
        true
    end

    def validate_div(elem)
        if elem.content.is_a(Array) && !elem.content.empty?
            puts "Evaluating a multiple node"
        end
        return false unless elem.content.is_a?(Array)

        elem.content.each do |child|
            valid = child.is_a?(H1) || child.is_a?(H2) || child.is_a?(Div) ||
                    child.is_a?(Table) || child.is_a?(Ul) || child.is_a?(Ol) ||
                    child.is_a?(Span) || child.is_a?(Text)

            return false unless valid
            return false unless validate(child)
        end
        true
    end

    def validate_body(elem)
        if elem.content.is_a?(Array) && !elem.content.empty?
            puts "Evaluating a multiple node"
        end
        return false unless elem.content.is_a?(Array)

        elem.content.each do |child|
            valid = child.is_a?(H1) || child.is_a?(H2) || child.is_a?(Div) ||
                    child.is_a?(Table) || child.is_a?(Ul) || child.is_a?(Ol) ||
                    child.is_a?(Span) || child.is_a?(Text) || child.is_a?(Img)

            return false unless valid
            return false unless validate(child)
        end
        true
    end

    def valid_element_type?(elem)
        valid_types = [Html, Head, Body, Title, Meta, Img, Table, Th, Tr, Td, Ul, Ol, Li, H1, H2, P, Div, Span, Hr, Br, Text]

        valid_types.any? { |type| elem.is_a?(type) }
    end

    def validate_html(elem)
        puts "Currently evaluating a Html :"
        puts '- root element of type "html"'
        puts "- Html -> Must contains a Head AND a Body after it"

        return false unless elem.content.is_a?(Array)
        return false unless elem.content.length == 2
        return false unless elem.content[0].is_a?(Head)
        return false unless elem.content[1].is_a?(Body)

        puts "Head is OK"
        
        elem.content.each do |child|
            return false unless validate(child)
        end
        true
    end

    def validate_head(elem)
        return false unless elem.content.is_a?(Array)
        return false unless elem.content.length == 1
        return false unless elem.content[0].is_a?(Title)

        validate(elem.content[0])
    end

    def validate_title(elem)
        return false unless elem.content.is_a?(Text)

        validate(elem.content)
    end

    def validate_text(elem)
        puts "Currently evaluating a Text :"
        puts "- Text -> Must contains a simple string"

        return false unless elem.content.is_a?(String)
        puts "Text content is OK"
        true
    end



end



if $PROGRAM_NAME == __FILE__

    puts "="*70
    puts "Test 1: valid html from pdf "
    puts "="*70

    toto = Html.new([
        Head.new([Title.new(Text.new("Hello ground!"))]),
        Body.new([
            H1.new(Text.new("Oh no, not again!")),
            Img.new([], {'src': Text.new('http://i.imgur.com/pfp3T.jpg')})
        ])
    ])

    test = Page.new(toto)
    test.is_valid?

 puts "="*70
    # puts "TEST FROM PDF ASSIGNMENT (Must match expected output!)"
    # puts "="*70
    
    # # Exact test from the PDF
    # result = Html.new([Head.new([Title.new("Hello ground!")]),
    #                    Body.new([H1.new("Oh no, not again!"),
    #                    Img.new([], {'src':'http://i.imgur.com/pfp3T.jpg'}) 
    #                    ]) 
    #                 ])
    # puts result
    
    puts "\n" + "="*70
    puts "BASIC ELEMENT TESTS"
    puts "="*70
    
    puts "\n1. Paragraph (P):"
    puts P.new("This is a simple paragraph.")
    
    puts "\n2. Heading 1 (H1):"
    puts H1.new("Main Title")
    
    puts "\n3. Heading 2 (H2):"
    puts H2.new("Subtitle")
    
    puts "\n4. Span:"
    puts Span.new("Inline text")
    
    puts "\n5. Div:"
    puts Div.new("Container content")
    
    puts "\n" + "="*70
    puts "SELF-CLOSING TAG TESTS"
    puts "="*70
    
    puts "\n6. Image with attributes:"
    puts Img.new([], {'src': 'photo.jpg', 'alt': 'My photo'})
    
    puts "\n7. Horizontal rule:"
    puts Hr.new
    
    puts "\n8. Line break:"
    puts Br.new
    
    puts "\n9. Meta tag:"
    puts Meta.new([], {'charset': 'UTF-8'})
    
    puts "\n" + "="*70
    puts "LIST TESTS"
    puts "="*70
    
    puts "\n10. Unordered list:"
    ul = Ul.new([
        Li.new("First item"),
        Li.new("Second item"),
        Li.new("Third item")
    ])
    puts ul
    
    puts "\n11. Ordered list with attributes:"
    ol = Ol.new([
        Li.new("Step one"),
        Li.new("Step two")
    ], {'class': 'instructions'})
    puts ol
    
    puts "\n" + "="*70
    puts "TABLE TESTS"
    puts "="*70
    
    puts "\n12. Simple table:"
    table = Table.new([
        Tr.new([
            Th.new("Name"),
            Th.new("Age")
        ]),
        Tr.new([
            Td.new("Alice"),
            Td.new("25")
        ]),
        Tr.new([
            Td.new("Bob"),
            Td.new("30")
        ])
    ])
    puts table
    
    puts "\n13. Table with attributes:"
    table2 = Table.new([
        Tr.new([Th.new("Product"), Th.new("Price")]),
        Tr.new([Td.new("Apple"), Td.new("$1")])
    ], {'border': '1', 'class': 'data-table'})
    puts table2
    
    puts "\n" + "="*70
    puts "NESTED STRUCTURE TESTS"
    puts "="*70
    
    puts "\n14. Div with multiple elements:"
    div = Div.new([
        H2.new("Section Title"),
        P.new("First paragraph."),
        P.new("Second paragraph."),
        Hr.new
    ], {'class': 'section'})
    puts div
    
    puts "\n15. Complete HTML page:"
    page = Html.new([
        Head.new([
            Title.new("My Website"),
            Meta.new([], {'charset': 'UTF-8'})
        ]),
        Body.new([
            H1.new("Welcome to My Site"),
            Div.new([
                P.new("This is the introduction."),
                Ul.new([
                    Li.new("Feature 1"),
                    Li.new("Feature 2")
                ])
            ], {'class': 'content'}),
            Hr.new,
            P.new("Footer text")
        ])
    ])
    puts page
    
    puts "\n" + "="*70
    puts "EDGE CASES"
    puts "="*70
    
    puts "\n16. Empty elements:"
    puts P.new([])
    puts Div.new([])
    
    puts "\n17. Multiple attributes:"
    puts Div.new("Content", {
        'id': 'main',
        'class': 'container',
        'data-value': '123'
    })
    
    puts "\n18. Deeply nested structure:"
    nested = Div.new([
        Div.new([
            Div.new([
                P.new("Deep content")
            ])
        ])
    ])
    puts nested
    
    puts "\n" + "="*70
    puts "ALL TESTS COMPLETED!"
    puts "="*70
end
