include("oppg1.jl")
include("oppg2.jl")
include("oppg3.jl")
include("oppg4.jl")

function legalindices(interval)
    return interval[1] != -1 && interval[2] != -1
end

function closestpair(x, y)
    x_left, x_right, y_left, y_right = splitintwo(x, y)
    
    if size(x_left)[1] > 3
        delta = min(closestpair(x_left, y_left), closestpair(x_right, y_right))

        x_interval = binaryintervalsearch(x, delta, 1)
        if legalindices(x_interval)
            delta = min(delta, bruteforce(x[x_interval[1]:x_interval[2], :]))
        end

        # println("If $(delta)")
        return delta
    else
        # Three or less elements in each list, brute force a solution
        return  min(bruteforce(x))
    end
end

function callclosestpair(arr)
    x = mergesort(arr, 1)
    y = mergesort(arr, 2)
    return closestpair(x, y)
end

function generatetestdata(n)
    return 100 * rand(n, 2)
end

function main()
    success = failure = 0

    for i in 1:1000
        testdata = generatetestdata(10)
        res1 = callclosestpair(testdata)
        res2 = bruteforce(testdata)
        if res1 == res2
            success += 1
        else
            failure += 1
        end
    end

    println("$(success) succeses")
    println("$(failure) failures")
end

main()