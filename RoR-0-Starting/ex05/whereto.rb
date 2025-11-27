#!/usr/bin/env -S ruby -w
DEBUG = false

def is_state?(states,name)
    if states.key?(name)
        return true
    else
        return false
    end
end


def is_capital?
end
def whereto
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
        return
    end

    input = ARGV[0].split(",")

    input.map! { | name | name.strip }
    input.map! { | name | name.capitalize }
    if DEBUG
        input.each do | name |
            puts name
        end
    end
    input.each do | name |
        if name == "New jersey"
            abbrevation = "NJ"
            name = "New Jersey"
        end
        if is_state?(states, name)
            abbrevation = states[name]
            capital_city_name = capitals_cities[abbrevation]
            puts "#{capital_city_name} is the capital of #{name} (akr: #{abbrevation})"
        end
    end
end
# $> ./Where.rb Oregon 
# Salem

# ./erehW.rb Salem 
# Oregon


whereto