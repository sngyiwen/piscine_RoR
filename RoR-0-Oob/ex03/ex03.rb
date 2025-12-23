#!/usr/bin/env -S ruby -w

class Text 
    attr_reader :content
    def initialize (content)
        @content = content
    end
    def to_s
        @content 
    end
end