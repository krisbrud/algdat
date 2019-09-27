include("oppg1.jl")
include("oppg2.jl")
include("oppg3.jl")
include("oppg4.jl")

function legalindices(interval)
    return interval[1] != -1 && interval[2] != -1
end

function closestpair(x,y)
    x_left, x_right, y_left, y_right = splitintwo(x, y)
    
    if size(x_left)[1] > 3
        delta = min(closestpair(x_left, y_left), closestpair(x_right, y_right))

        x_interval = binaryintervalsearch(x, delta, 1)
        if legalindices(x_interval)
            delta = min(delta, bruteforce(x[x_interval[1]:x_interval[2]]))
        end

        y_interval = binaryintervalsearch(y, delta, 2)
        if legalindices(y_interval)
            delta = min(delta, bruteforce(y[y_interval[1]:y_interval[2]]))
        end

        return delta
    else
        # Three or less elements in each list, brute force a solution
        return min(bruteforce(x_left), bruteforce(x_right))
    end
end