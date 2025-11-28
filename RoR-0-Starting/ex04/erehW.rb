#!/usr/bin/env -S ruby -w

TEST = false

def run_test
    test_cases = [
        ["Salem", "Oregon"],
        ["Montgomery", "Alabama"],
        ["Trenton", "New Jersey"],
        ["Denver", "Colorado"],
        ["Singapore", "Unknown capital city"],
    ]
    puts "====> RUNNING TESTS <====="
    puts "------------------------"

    test_cases.each do | input, expected |
        output = `./erehW.rb #{input}`.strip
        status = (output == expected) ? "OK ✅" : "FAIL ❌"
        printf "%-12s → %-22s [%s]\n", input, output, status
    end
    puts "------------------------"
    puts "====> END OF TESTS <====="
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

    if ARGV.size != 1
        return 
    end

    capital = ARGV[0]
    abbrevation = nil
    capitals_cities.each do |code, city|
        if city == capital
            abbrevation = code
            break
        end
    end

    if abbrevation.nil?
        puts "Unknown capital city"
        return 
    end

    state = nil
    states.each do |state_name, code|
        if code == abbrevation
            state = state_name
            break
        end
    end
    puts state
end

erehw