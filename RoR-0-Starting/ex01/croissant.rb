#!/usr/bin/env -S ruby -w

DEBUG = false

def sorted_ascending?(arr)
  (0...arr.length - 1).each do |i|
    if arr[i] > arr[i + 1]
        return false 
    end
  end
  true
end

def arr_size(arr)
    arr.size
end


def croissant
    content = File.read("numbers.txt")
    numbers = content.split(",")
    numbers.map! { |number_in_array| number_in_array.to_i }
    numbers.sort!
    if DEBUG
        puts "total numbers in array: #{arr_size(numbers)}"
        puts "sorted ascending? #{sorted_ascending?(numbers)}"
    end

    numbers.each do |number_in_array|
        puts number_in_array
    end
end

croissant