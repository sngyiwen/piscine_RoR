#!/usr/bin/env -S ruby -w

TEST = true


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
    
    if ARGV.size < 1
        exit 1
    end

    long_form = ARGV.join(' ')
    
    abbrevation = states[long_form];

    if TEST
        run_test
        return
    end

    if abbrevation.nil?
        puts "Unknown state"
        return
    end

    capital_city = capitals_cities[abbrevation]
    
    puts capital_city
end  

where