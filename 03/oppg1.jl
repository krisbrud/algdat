# For å kunne gjøre dette trenger vi en sorterings algoritme med kjøretid O(nlogn).

# Derfor skal du implementere mergesort, men med en liten tvist.

# Arrayet du skal sortere er en samling av (x,y) koordinater, og man skal kunne velge om man vil sortere etter x eller y koordinatet.

# Altså du vil motta et array på formen [1 2; 4 6; 2 1] og en koordinat akse (1 (x) eller 2 (y))

# Kall av mergesort([1 2; 4 6; 2 1],1) skal returnere [1 2; 2 1; 4 6]

# og mergesort([1 2; 4 5; 2 1],2) skal returnere [2 1; 1 2; 4 5]

# Hint 1: begynn med å implementere en hjelpefunksjon for flettetrinnet som tar inn to sorterte array og koordinat-aksen du skal flette langs.

# Hint 2: hvis du sliter med å implementere mergesort, prøv først å implementere i én dimensjon før du utvider til å kunne velge dimensjon.

arr = [1 2; 4 6; 2 1]

#x og y er to sorterte arrays, coordinate angir koordinat akse

# Sorter venstre halvdel rekursivt
# Sorter høyre halvdel rekursivt
# Flett sammen halvdelene

function mergearrays(x,y,coordinate)
    println("mergearrays()")
    # calculate result matrix dimensions
    rows = size(x)[1] + size(y)[1]
    cols = size(x)[2] # assume same number of cols
    merged = zeros(rows, cols)

    x = [x; fill(Inf, 1, cols)]
    y = [y; fill(Inf, 1, cols)]

    i = 1 # x iterator
    j = 1 # y iterator

    println("x")
    println(x)
    println("y")
    println(y)

    for k = 1:rows
        println("k: ", k, " i: ", i, " j: ", j)
        println("merged")
        println(merged)
        if x[i, :][coordinate] <= y[j, :][coordinate]
            println("inside merge if")
            merged[k, :] = x[i, :]' # slice returns column vector, need to transpose
            i += 1
        else
            println("inside merge else")
            merged[k, :] = y[j, :]'
            j += 1
        end
    end

    return merged
end

#x usortert array, coordinate angir koordinat akse vi skal sortere langs
function mergesort(x, coordinate)
    println("mergesort()")
    mid = div(size(x)[1], 2) # get the number of rows using size, not number of total elements
    println(x, " ", coordinate, " ", mid)
    
    if size(x)[1] > 1 # length greater than 2
        left = mergesort(x[1:mid, :], coordinate)    
        right = mergesort(x[mid+1:size(x)[1], :], coordinate)
        return mergearrays(left, right, coordinate)
    end

    return x
end

# println(size(arr))
result = mergesort(arr, 2)
println(result)
