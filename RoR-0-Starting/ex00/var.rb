#!/usr/bin/env -S ruby -w

def my_var
    a = 10
    b = "10"
    c = nil
    d = 10.0

    puts "my variables :"
    puts "a contains: #{a.inspect} and is a type: #{a.class}"
    puts "b contains: #{b.inspect} and is a type: #{b.class}"
    puts "c contains: #{c.inspect} and is a type: #{c.class}"
    puts "d contains: #{d.inspect} and is a type: #{d.class}"
end

my_var