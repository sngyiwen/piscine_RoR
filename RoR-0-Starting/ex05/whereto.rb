#!/usr/bin/env -S ruby -w
DEBUG = false

def whereto
    # states = {
    #     "Oregon" => "OR",
    #     "Alabama" => "AL",
    #     "New Jersey" => "NJ",
    #     "Colorado" => "CO"
    # }
    # capitals_cities = {
    #     "OR" => "Salem",
    #     "AL" => "Montgomery",
    #     "NJ" => "Trenton",
    #     "CO" => "Denver"
    # }

    if ARGV.size != 1
        return
    end
    input = ARGV[0].split(",")
    if DEBUG
        input.map { | name | name.strip! }
        input.each do | name |
            puts name
        end
    end
end

whereto