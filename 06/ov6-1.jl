function lislength(s)
    mls = zeros(Int, size(s))
    mls[1] = 1

    longest = 0

    for i = 2:length(s)
        # Din kode her
        if s[i] > s[i-1]
            longest += 1
            mls[i] = max(longest, mls[i-1])
        else
            longest = 1
        end
    end
    return maximum(mls) # Returnerer det største tallet i listen
end


function test_sequence(s, expected)
    println("Maximum increasing subsequence of $s: $(lislength(s)), expected $expected")
end

test_sequence([5,3,3,6,7], 3)
test_sequence([5,2,3,6,7], 4)
test_sequence([5,6,3,6,2], 2)
test_sequence([5,4,3,2,1], 1)


