x = [1 2; 2 3; 3 0; 4 0; 5 1]
delta = 1.5
coordinate = 1
# x = [1 2; 2 0; 3 3; 4 4]
# delta = 0.25
# coordinate = 1

function binaryintervalsearch(x, delta, coordinate)
    # Find median
    x_size = size(x)[1]
    if (x_size % 2) == 1
        # Odd number of points
        median = x[1 + div(x_size, 2)]
    else
        # Even number of points
        median = (x[div(x_size, 2)] + x[div(x_size, 2) + 1]) / 2
    end

    # Find lower interval index
    lo = 1
    hi = div(x_size, 2)

    # Want to find the lowest index where the element is greater than median - delta
    while lo < hi
        mid = div(lo + hi, 2)
        println("Low: ", lo, " mid: ", mid, " hi: ", hi)
        if median - delta >= x[mid][coordinate]
            lo = mid + 1
        else
            hi = mid
        end
    end

    println("Median ", median)

    # println("Low: ", lo, " hi: ", hi)

    # println("Low index before ", lo)

    if x[lo][coordinate] < median - delta
        # In case the found index is outside the interval
        lo = -1
    end
    
    lower_idx = lo

    # Find high index
    println("High index")

    lo = div(x_size, 2) + 1
    hi = x_size

    while lo < hi
        mid = div(lo + hi, 2) + 1
        println("Low: ", lo, " mid: ", mid, " hi: ", hi)
        if x[mid][coordinate] > median + delta
            hi = mid - 1
        else
            lo = mid
        end
    end
    println("After while. Low: ", lo, ", hi: ", hi)

    high_idx = hi

    if x[hi][coordinate] > median + delta
        high_idx = -1
    end

    return [lower_idx, high_idx]
end

println(x)
println(delta)
println(binaryintervalsearch(x, delta, coordinate))