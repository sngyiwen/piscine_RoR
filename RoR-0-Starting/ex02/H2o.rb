#!/usr/bin/env -S ruby -w

def convert_to_hash(data)
    hash = {}
    data.each do |name, number|
        if hash[number].nil?
            hash[number] = [name]
        else 
            hash[number] << name
        end
    end
    hash
end


def h2o
    data = [['Caleb' , 24],
    ['Calixte' , 84],
    ['Calliste', 65],
    ['Calvin' , 12],
    ['Cameron' , 54],
    ['Camil' , 32],
    ['Camille' , 5],
    ['Can' , 52],
    ['Caner' , 56],
    ['Cantin' , 4],
    ['Carl' , 1],
    ['Carlito' , 23],
    ['Carlo' , 19],
    ['Carlos' , 26],
    ['Carter' , 54],
    ['Casey' , 2]]

    hash = convert_to_hash(data)

    hash.keys.sort.each do |key|
        puts "#{key} : #{hash[key].join(' ')}"
    end
end

h2o