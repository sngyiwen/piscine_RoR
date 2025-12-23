#!/usr/bin/env -S ruby -w

class Dup_file < StandardError
    attr_reader :old_path
    attr_reader :new_path
    attr_reader :new_filename

    def initialize(filename)
        @filename = filename
        @old_path = File.expand_path(filename)
        new_filename = filename

        loop do 
            if new_filename.end_with?(".html")
                base = new_filename[0...-5]
                new_filename = base + ".new.html"
            else
                new_filename = new_filename + ".new.html"
            end
            unless File.exist?(new_filename)
                break
            end
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
        lines.each_with_index do |line, idx|
            if line.strip == "</body>"
                puts "In #{@filename} body was closed: "
                puts "> ln :#{idx + 1} </body> : text has been inserted and tag moved at the end of it."
                return
            end
        end
    end

    def correct
        lines = File.readlines(@filename)
        body_line_idx = nil
        html_line_idx = nil

        lines.each_with_index do |line, idx|
            if line.strip =="</body>"
                body_line_idx = idx
            elsif line.strip == "</html>"
                html_line_idx = idx
            end
        end

        if body_line_idx

            new_lines = []
            lines.each_with_index do |line, idx|
                unless idx == body_line_idx || idx == html_line_idx
                    new_lines << line
                end
            end

            new_lines << "    <p>#{@text}</p>\n"

            new_lines << "</body>\n"
            new_lines << "</html>\n"

            File.write(@filename, new_lines.join)
        end
    end

    def explain
        puts "The body tag has been reopened, text inserted, and body tag closed again."
    end
end

class Html
    attr_reader :page_name

    def head 
        if File.exist?(@filename)
            raise Dup_file.new(@filename)
        end
        
        File.open(@filename, "w") do |f|
            f.puts "<!DOCTYPE html>"
            f.puts "<html>"
            f.puts "<head>"
            f.puts "<title>#{@page_name}</title>"
            f.puts "</head>"
            f.puts "<body>"
        end
        @body_open = true
    end

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

    def dump(str)
        unless @body_open
            raise RuntimeError, "There is no body tag in #{@filename}"
        end
        if @body_closed
            begin 
                raise Body_closed.new(@filename, str)
            rescue Body_closed => e
                e.show_state
                e.correct
                e.explain
                return 
            end
        end
        File.open(@filename, "a") do |f|
            f.puts "    <p>#{str}</p>"
        end
    end

    def finish
        if @body_closed
            raise RuntimeError, "#{@filename} has already been closed"
        end

        unless @body_open
            raise RuntimeError, "There is no body tag in #{@filename}"
        end

        File.open(@filename, "a") do |f|
            f.puts "</body>"
            f.puts "</html>"
        end
        @body_closed = true
    end
end

if $PROGRAM_NAME == __FILE__
    puts "==> Test 1: Creating a file <=="
    a = Html.new("test")
    3.times { |x| a.dump("titi_number#{x}") }
    a.finish

    puts "==> Test 2: Attempting to create a duplicate file <=="
    b = Html.new("test")
    b.dump("this is content in new file")
    b.finish

    puts "==> Test 3: Dump after body is closed <=="
    a.dump("trying to add after close")

    puts "==> Test 4: Finish after alread closed <=="
    begin
        a.finish
    rescue RuntimeError => e
        puts "Error caught: #{e.message}"
    end

    puts "\n=== Test 5: Check file contents ==="
    puts "\n--- test.html ---"
    puts File.read("test.html")

    if File.exists?("test.new.html")
        puts "\n--- test.new.html ---"
        puts File.read("test.new.html")
    end
end