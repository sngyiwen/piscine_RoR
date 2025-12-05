#!/usr/bin/env -S ruby -w

TEST = false
DEBUG = false

TABLE_WIDTH = 18
TABLE_HEIGHT = 10

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

    html = "<td id='ele'>\n"
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

def populate_periodic_table(elements)
    html = ""
    cell_position  = 0
    elements.each_with_index do |element, index|
        if DEBUG
            puts "this is in the do loop #{index} : #{element[:name]}"
        end
       if element[:position] == 0
            html << "<tr>\n"
       end
       if element[:position] == cell_position
            html << elm(element)
            cell_position += 1
       else
            while cell_position < element[:position]
                html << "<td></td>\n"
                cell_position += 1
            end
            if cell_position == element[:position]
                html << elm(element)
                cell_position += 1
            end
       end
       if element[:position] == TABLE_WIDTH - 1
            html << "</tr>\n"
            cell_position = 0
       end
    end
    html
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

    html << populate_periodic_table(elements)

    html << "   </table>\n"
    html << "</body>\n"
    html << "</html>\n"
    
    html
end


def main
    file_path = "periodic_table.txt"
    unless File.exist?(file_path)
        warn "Error: The required file '#{file_path}' was not found in the current directory."
        exit 1
    end
    elements = read_elements(file_path)
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

        elements.first(88).each do |line|
            puts "#{line[:number]} : #{line[:name]} (pos #{line[:position]}, symbol #{line[:small]})"
        end
    else 
        main 
    end
end
