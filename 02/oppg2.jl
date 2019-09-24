# Visste du at funksjoner kan ha emoji i navnet?  💯
s = [2, 4, 6, 8, 9]

function reverseandlimit(array, maxnumber)
    new_arr = []
    for i in length(array):-1:1
        if array[i] > maxnumber
            push!(new_arr, maxnumber)
        else
            push!(new_arr, array[i])
        end
    end

    return new_arr
end