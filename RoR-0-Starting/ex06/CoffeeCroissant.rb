#!/usr/bin/env -S ruby -w

def convert_to_hash(data)
    hash = {}

    data.each do |name, age|
        if hash[age].nil? 
            hash[age] = [name]
        else 
            hash[age] << name
        end
    end
    hash
end

def coffeeCroissant

    data = [
        ['Frank', 33],
        ['Stacy', 15],
        ['Juan' , 24],
        ['Dom' , 32],
        ['Steve', 24],
        ['Jill', 24]
    ]

    hash = convert_to_hash(data)

    hash.keys.sort.each do |key|

        sorted_names = hash[key].sort

        sorted_names.each do |name|
            puts name
        end
    end
end

coffeeCroissant