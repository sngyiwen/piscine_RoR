#!/usr/bin/env -S ruby -w

TEST = false

def run_test

    test_cases = [
        ["Oregon", "Salem"],
        ["Alabama", "Montgomery"],
        ["New Jersey", "Trenton"],
        ["Colorado", "Denver"],
        ["Singapore", "Unknown state"],
    ]

    puts "====> RUNNING TESTS <====="
    puts "------------------------"

    test_cases.each do |input, expected|
        output = `./Where.rb #{input}`.strip
        status = (output == expected) ? "OK ✅" : "FAIL ❌"
        printf "%-12s → %-22s [%s]\n", input, output, status
    end
    puts "------------------------"
    puts "====> END OF TESTS <====="
end

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
    if TEST && ARGV.size < 1
        run_test
        return
    end

    if ARGV.size < 1 || ARGV.size > 2
        return 
    end

    if ARGV.size == 2
        new_jersey_test = ARGV.join(' ')
        if new_jersey_test != "New Jersey"
            return 
        end
    end
    
    long_form = ARGV.join(' ')
    
    abbrevation = states[long_form];



    if abbrevation.nil?
        puts "Unknown state"
        return
    end

    capital_city = capitals_cities[abbrevation]
    
    puts capital_city
end  

where