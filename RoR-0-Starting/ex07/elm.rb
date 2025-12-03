#!/usr/bin/env -S ruby -w

TEST = false

TABLE_WIDTH = 18

def format_electron(e)
    e = e.strip
    if e == "1"
        "1 electron"
    else 
        "#{e} electrons"
    end
end

def parse_line(line)
    name_part, attributes_part = line.split(" = ", 2)

    if name_part.nil? || attributes_part.nil?
        return nil
    end
    attrs = {}
    attributes_part.split(',').each do |chunk|
        key, value = chunk.split(':', 2)
        if key.nil? || value.nil?
            return nil
        end
        attrs[key.strip] = value.strip
    end
    {
        name: name_part.strip,
        position: attrs['position'].to_i,
        number: attrs['number'].to_i,
        small: attrs['small'],
        molar: attrs['molar'],
        electron: attrs['electron']
    }
end

def elm(element)

    html = "<td style= \"border: 1px solid black; padding: 10px\">\n"
    html << "    <h4>#{element[:name]}</h4>\n"
    html << "    <ul>\n"
    html << "       <li>No #{element[:number]}</li>\n"
    html << "       <li>#{element[:small]}</li>\n"
    html << "       <li>#{element[:molar]}</li>\n"
    html << "       <li>#{format_electron(element[:electron])}</li>\n"
    html << "    </ul>\n"
    html << "</td>\n"
    html
end

def read_elements(path)
    elements = []

    File.readlines(path).each do |line|
        line = line.strip
        if line.empty?
            next
        end
        element = parse_line(line)
        if element
            elements << element
        end
    end
    elements
end

def build_html(elements)
    html = ""
    html << "<!DOCTYPE html>\n"
    html << "<html lang=\"en\">\n"
    html << "<head>\n"
    html << "    <meta charset=\"UTF-8\">\n"
    html << "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
    html << "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n"
    html << "    <title>Periodic table</title>\n"
    html << "    <style>\n"
    html << "       table { border-collapse: collapse; }\n"
    html << "       #ele { border: 1px solid black; padding: 10px; }\n"
    html << "        td {min-width: 30px; }\n"
    html << "    </style>\n"
    html << "</head>\n"
    html << "<body>\n"
    html << "   <table>\n"

    
    

    html << "   </table>\n"
    html << "</body>\n"
    html << "</html>\n"
    
    html
end


def main
    elements = read_elements("periodic_table.txt")
    html = build_html(elements)
    File.write("periodic_table.html", html)
end

if __FILE__ ==  $PROGRAM_NAME
    if TEST
        test_line = "Hydrogen = position:0, number:1, small: H, molar:1.00794, electron:1"
    
        puts "Parsed hash:"
        element = parse_line(test_line)
        p element

        puts "\nHTML output:"
        puts elm(element)   
        
        puts "\n== HTML Parsing Test=="
        elements = read_elements("periodic_table.txt")
        puts "total elements parse: #{elements.size}"

        elements.first(5).each do |line|
            puts "#{line[:number]} : #{line[:name]} (pos #{line[:position]}, symbol #{line[:small]})"
        end
    else 
        main 
    end
end
