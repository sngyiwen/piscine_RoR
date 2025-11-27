#!/usr/bin/env -S ruby -w
DEBUG = true

def is_state?(states,name)
    if states.key?(name)
        return true
    else
        return false
    end
end


def is_capital?

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

    if DEBUG
        input.map { | name | name.strip! }
        input.map { | name | name.downcase! }
        input.each do | name |
            puts name
        end
    end



end

whereto