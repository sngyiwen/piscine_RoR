#!/usr/bin/env -S ruby -w

TEST = false

def run_test


end

def erehw

    states = {
        "Oregon" => "OR",
        "Alabama" => "AL",
        "New Jersey" => "NJ",
        "Colorado" => "CO"
    }
    capitals_cities = {
        "OR" => "Salem",
        "AL" => "Montgomery",
        "NJ" => "Trenton",
        "CO" => "Denver"
    }
    if TEST && ARGV.size < 1
        run_test
        return
    end

    if ARGV.size < 1 || ARGV.size > 2
        return 1
    end

   
end  

erehw