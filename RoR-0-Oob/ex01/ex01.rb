#!/usr/bin/env -S ruby -w
class Html
    attr_reader :page_name

    def initialize(name)
        @page_name = name
        @filename = "#{name}.html"
        @body_open = false
        @body_close = false
        head
    end

    def head
            if head.exist?(@filename) 
                raise "A file named #{@filename} already exists!"
            end
            File.open(@filename, "w") do |f|
            f.puts"<!DOCTYPE html>"
            f.puts"<html>"
            f.puts"<head>"
            f.puts"<title>#{@page_name}</title>"
            f.puts"</head>"
            f.puts"<body>"
        end
        @boody_open = true
    end

    def dump(str)
        unless @body_open
            raise "There is no body tag in #{@filename}"
        end

        if @body_close
            raise "The body has already been closed in #{@filename}"
        end
        line = "    <p>#{str}</p>\n"
        File.open(@filename, "a") do |f|
            f.write line
        end
        line.bytesize
    end
    
    def finish
        if @body_close
            raise "#{@filename} has already been closed"
        end

        unless @body_open
            raise "There is no body tag in #{@filename}"
        end
        lines = "</body>\n</html>"
        File.open(@filename, "a") do |f|
            f.write lines
        end
        @body_close = true
        lines.bytesize
    end
end

if $PROGRAM_NAME == __FILE__
    a = Html.new("test")
    10.times{|x| a.dump("titi_number#{x}")}
    a.finish
end