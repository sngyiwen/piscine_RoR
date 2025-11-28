#!/usr/bin/env -S ruby -w
DEBUG = false
TEST = false

def run_tests
  puts "==== RUNNING TESTS ====\n\n"

  tests = [
    {
      input: "Oregon",
      expected: "Salem is the capital of Oregon (akr: OR)"
    },
    {
      input: "Denver",
      expected: "Denver is the capital of Colorado (akr: CO)"
    },
    {
      input: "Alabama",
      expected: "Montgomery is the capital of Alabama (akr: AL)"
    },
    {
      input: "Batman",
      expected: "Batman is neither a capital city nor a state"
    },
    {
      input: "Salem, Alabama, Toto, MontGOmery",
      expected: [
        "Salem is the capital of Oregon (akr: OR)",
        "Montgomery is the capital of Alabama (akr: AL)",
        "Toto is neither a capital city nor a state",
        "Montgomery is the capital of Alabama (akr: AL)"
      ].join("\n")
    }
  ]

  tests.each do |t|
    input_str = t[:input]
    expected_str = t[:expected]

    # Show evaluator the exact command
    puts "$ ./whereto.rb #{input_str}"
    puts "EXPECTED:"
    puts "  #{expected_str.gsub("\n", "\n  ")}"

    # Run real program
    actual_str = `./whereto.rb "#{input_str}"`.strip

    puts "ACTUAL:"
    puts "  #{actual_str.gsub("\n", "\n  ")}"

    # Compare
    if actual_str == expected_str
      puts "RESULT: OK ✅"
    else
      puts "RESULT: FAIL ❌"
    end

    puts "-" * 50
  end

  puts "\n==== END OF TESTS ====\n"
end



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
        if name.strip == ""
            next
        end
        if (!is_state?(states, name) && !is_capital?(capitals_cities, name))
            puts "#{name} is neither a capital city nor a state"
        elsif is_state?(states, name)
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
if TEST && ARGV.size < 1
  run_tests
else
  whereto
end