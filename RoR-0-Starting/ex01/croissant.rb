DEBUG = false
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
    end

    numbers.each do |number_in_array|
        puts number_in_array
    end
end

croissant