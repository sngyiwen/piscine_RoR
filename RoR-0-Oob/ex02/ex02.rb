#!/usr/bin/env -S ruby -w

class Dup_file < StandardError
    attr_reader :old_path
    attr_reader :new_path
    attr_reader :new_filename

    def initialize(filename)
        @filename = filename
        @old_path = File.expand_path(filename)
        @new_filename = filename

        loop do 
            if new_filename.end_with?(".html")
                base = filename[0...-5]
                new_filename = base + ".new.html"
            else
                new_filename = new_filename + ".new.html"
            end
            unless File.exist?(new_filename)
                break
        end
        @new_path = File.expand_path(new_filename)
        @new_filename = new_filename    
        super()
    end

    def show_state
        puts "A file named #{@filename} was already there: #{@old_path}"
    end

    def correct
        puts "Appended .new in order to create requested file: #{@new_path}"
        @new_filename
    end

    def explain
        puts "The new file has been created successfully at: #{@new_path}"
    end
end

class Body_closed < StandardError
    attr_reader :filename
    attr_reader :text

    def initialize(filename, text)
        @filename = filename
        @text = text
        super()
    end

    def show_state
        lines = File.readlines(@filename)
    end

    def correct
        puts "Do not call dump/finish after the body is closed."
    end

    def explain
        puts "Once </body> tag is used to close the body tag, you cannot add more content."
    end
end

class Html
    attr_reader :page_name

    def initialize(name)
        @page_name = name
        @filename = "#{name}.html"
        @body_open = false
        @body_closed = false
        loop do 
            begin 
                head
                break
            rescue Dup_file => e
                e.show_state
                e.correct
                e.explain
                @filename = e.new_filename
                @page_name = File.basename(e.new_filename, ".html")
            end
        end
    end

    def head
        if File.exist?(@filename) 
            raise Dup_file.new(@filename)
        end
        File.open(@filename, "w") do |f|
            f.puts"<!DOCTYPE html>"
            f.puts"<html>"
            f.puts"<head>"
            f.puts"<title>#{@page_name}</title>"
            f.puts"</head>"
            f.puts"<body>"
        end
        @body_open = true
        nil
    end

    def dump(str)
        begin 
            unless @body_open
                raise "There is no body tag in #{@filename}"
            end
            if @body_closed
                raise Body_closed.new(@filename)
            end
            line = "    <p>#{str}</p>\n"
            File.open(@filename, "a") do |f|
                f.write line
            end
            nil
        rescue Body_closed => e
            e.show_state
            e.correct
            e.explain
            nil
        rescue RuntimeError => e
            puts e.message
            nil
        end
        # line.bytesize
    end
    
    def finish
        begin 
            if @body_closed
                raise Body_closed.new(@filename)
            end

            unless @body_open
                raise "There is no body tag in #{@filename}"
            end

            lines = "</body>\n</html>\n"
            File.open(@filename, "a") do |f|
                f.write lines
            end
            @body_closed = true
            nil
        rescue Body_closed => e
            e.show_state
            e.correct
            e.explain
            nil
        rescue RuntimeError => e
            puts e.message
            nil
        end
        # lines.bytesize
    end
end

if $PROGRAM_NAME == __FILE__
    a = Html.new("test")
    3.times{|x| a.dump("titi_number#{x}")}
    a.finish
    a.dump("after close")
    a.finish
end   