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

    capital = ARGV[0]
    abbrevation = nil
    capitals_cities.each do |code, city|
        if city == capital
            abbrevation = code
            break
        end
    end

    if abbrevation.nil?
        puts "Unknown capital"
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