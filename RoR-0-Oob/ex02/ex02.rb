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
        lines.each_with_index do |line, idx|
            if line.strip == "</body>"
                puts "In #{@filename} body was closed :"
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

            new_lines << << "    <p>#{@text}</p>\n"

            new_lines << "</body>\n"
            new_lines << "</html>\n"

            File.write(@filename, new_lines.join)
        end
    end

    def explain
        puts "The body tag has been reopened, text inserted, and body tag closed again."
    end
end


if $PROGRAM_NAME == __FILE__
    a = Html.new("test")
    3.times{|x| a.dump("titi_number#{x}")}
    a.finish
    a.dump("after close")
    a.finish
end   