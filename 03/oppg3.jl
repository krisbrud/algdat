# Bruteforce finding of least distance between two points

function bruteforce(x)
    smallest = Inf
    num_points = size(x)[1]

    dist = (x, y) -> x^2 + y^2

    for i in 1:num_points
        for j in i+1:num_points
            d = dist(x[i, 1] - x[j, 1], x[i, 2] - x[j, 2]) 
            if  d < smallest
                smallest = d
            end
        end
    end

    return sqrt(smallest)
end