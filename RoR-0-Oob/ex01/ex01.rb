#!/usr/bin/env -S ruby -w
class Html
    attr_reader :page_name

    def initialize(name)
        @page_name = name
        @filename = "#{name}.html"
        head
    end

    def head
            File.open(@filename, "w") do |f|
            f.puts"<!DOCTYPE html>"
            f.puts"<html>"
            f.puts"<head>"
            f.puts"<title>#{@page_name}</title>"
            f.puts"</head>"
            f.puts"<body>"
        end
    end

    def dump(str)
        line = "    <p>#{str}</p>\n"
        File.open(@filename, "a") do |f|
            f.write line
        end
        line.bytesize
    end
    
    def finish
        lines = "</body>\n</html>"
        File.open(@filename, "a") do |f|
            f.write lines
        end
        lines.bytesize
    end
end

if $PROGRAM_NAME == __FILE__
    a = Html.new("test")
    10.times{|x| a.dump("titi_number#{x}")}
    a.finish
end