#!/usr/bin/env -S ruby -w

require_relative '../ex03/ex03.rb'

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
    


if $PROGRAM_NAME == __FILE__
 puts "="*70
    puts "TEST FROM PDF ASSIGNMENT (Must match expected output!)"
    puts "="*70
    
    # Exact test from the PDF
    result = Html.new([Head.new([Title.new("Hello ground!")]),
                       Body.new([H1.new("Oh no, not again!"),
                       Img.new([], {'src':'http://i.imgur.com/pfp3T.jpg'}) ]) ])
    puts result
    
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
