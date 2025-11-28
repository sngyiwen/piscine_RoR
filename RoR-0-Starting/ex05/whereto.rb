#!/usr/bin/env -S ruby -w
DEBUG = false

def is_state?(states,name)
    if states.key?(name)
        return true
    else
        return false
    end
end

def is_capital?(capitals_cities, name)
    capital_city_name = name
    capitals_cities.each do |code, city|
        if capital_city_name == city
           return true
        end
    end
    return false
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
        abbrevation = nil
        capital_city_name = nil

        if name == "New jersey"
            abbrevation = "NJ"
            name = "New Jersey"
        end
        if (!is_state?(states, name) || !is_capital?(capital_cities, name))
            puts "#{name} is neither a capital city nor a state"
            return
        end    
        if is_state?(states, name)
            abbrevation = states[name]
            capital_city_name = capitals_cities[abbrevation]
            puts "#{capital_city_name} is the capital of #{name} (akr: #{abbrevation})"
        elsif is_capital?(capitals_cities, name)
            capitals_cities.each do | key, value |
                if name == value
                    abbrevation = key
                    break
                end
            end
            states.each do |key, value|
                if abbrevation == value
                    capital_city_name = key
                end
            end
            puts "#{name} is the capital of #{capital_city_name} (akr: #{abbrevation})"
        end
    end
end
whereto