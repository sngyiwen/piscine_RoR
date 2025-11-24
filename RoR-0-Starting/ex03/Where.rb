#!/usr/bin/env -S ruby -w

def where

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

    if ARGV.size != 1
        exit 1
    end

    if ARGV.size == 2 && ARGV[0] != "New" && ARGV[1] != "Jersey"
        exit 1
    end
    abbrevation = states[ARGV[0]];

    if abbrevation.nil?
        puts "Unknown state"
        return
    end

    capital_city = capitals_cities[abbrevation]
    
    puts capital_city
end  

where