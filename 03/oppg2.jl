function lowest_satisfying_comp(x, comp_func)
    # Want to find the lowest index where the element is greater than median - delta
    lo = 1
    hi = length(x)

    println(x)
    
    while lo < hi
        mid = div(lo + hi, 2)
        println("Low: ", lo, " mid: ", mid, " hi: ", hi)
        if !comp_func(x[mid])
            # Elementet ved mid for liten -> juster opp lo
            lo = mid + 1
        else
                # Elementet at index mid greater or eq.
                # Check if this is the first element
            if mid == 1
                lo = hi = 1 # breaks the while loop
            elseif !comp_func(x[mid - 1])
                    # Check if at thresh.
                lo = hi = mid
            else
                    # Make hi index lower
                hi = mid
            end
        end
    end

    println("Found: ", lo)
    return comp_func(x[lo]) ? lo : -1
end

function binaryintervalsearch(x, delta, coordinate)
    # Find median
    x_size = size(x)[1]

    # println(x[1 + div(x_size, 2), coordinate])
    println("Etter")
    if (x_size % 2) == 1
        # Odd number of points
        median = x[1 + div(x_size, 2), coordinate]
    else
        # Even number of points
        median = (x[div(x_size, 2), coordinate] + x[div(x_size, 2) + 1, coordinate]) / 2
    end

    # Find mid index
    mid = div(x_size + 1, 2)

    lower_lim = median - delta
    upper_lim = median + delta

    lower_comp_func = x -> x >= lower_lim
    upper_comp_func = x -> x <= upper_lim

    println("Median ", median)
    println(x[1:mid, coordinate])
    println("mid global ", mid)

    lo_idx = lowest_satisfying_comp(x[1:mid, coordinate], lower_comp_func)
    hi_idx = lowest_satisfying_comp(reverse(x[(x_size % 2 == 0 ? mid + 1 : mid):x_size, coordinate]), upper_comp_func)
    
    if hi_idx != -1
        hi_idx = x_size + 1 - hi_idx
    end

    return [lo_idx, hi_idx]
    
    # lower_idx = lo

    # # Find high index
    # println("High index")

    # lo = div(x_size + 1, 2) # +1 before flooring fixes the case of both odd and even numbers
    # hi = x_size

    # while lo < hi
    #     mid = div(lo + hi, 2) + 1
    #     println("Low: ", lo, " mid: ", mid, " hi: ", hi)
    #     if x[mid][coordinate] > median + delta
    #         hi = mid - 1
    #     else
    #         lo = mid
    #     end
    # end
    # println("After while. Low: ", lo, ", hi: ", hi)

    
    # if x[hi][coordinate] > median + delta
    #     hi = -1
    # end

    # return [lower_idx, hi]
end

function testcase(x, delta, coordinate)
    println("x: ", x)    
    println("delta: ", delta, " coordinate: ", coordinate)
    println(binaryintervalsearch(x, delta, coordinate), "\n")
end

testcase([1 2; 2 3; 3 0; 4 0; 5 1], 1.5, 1)

testcase([1 2; 2 0; 3 3; 4 4], 0.25, 1)
# testcase([1 2; 2 0; 3 3; 4 4], 0.25, 2) # crashes because not sorted after second axis

testcase([1.0 0.0; 2.0 0.0; 3.0 0.0], 0.5, 1)
# testcase([1.0 0.0; 2.0 0.0; 3.0 0.0], 0.5, 2)

testcase([1.0 -1.0; 2.0 2.0; 3.0 3.0; 4.0 5.0; 5.0 5.0], 1, 1)

testcase([1.0 0.0; 2.0 0.0; 3.0 0.0; 4.0 0.0], 3, 1)

testcase([1.0 0.0; 2.0 0.0; 3.0 0.0; 4.0 0.0], 0.1, 1)
testcase([1.0 0.0; 2.0 0.0; 3.0 0.0; 4.0 0.0], 0.1, 2)