function lislength(s)
    mls = ones(Int, size(s))

    for i = 2:length(s)
        for j = 1:i-1
            if s[i] > s[j]
                # Irrelevant which subsequence of the same length we pick,
                # as every subseq. containing this number must have the next 
                # number must also contain this one
                mls[i] = max(mls[i], mls[j] + 1)
            end
        end
    end
    return maximum(mls) # Returnerer det største tallet i listen
end


printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test lislength([5,3,3,6,7]) == 3
	@test lislength([2,2,2,2]) == 1
	@test lislength([100,50,25,10]) == 1
	@test lislength([0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]) == 6
	@test lislength([682, 52, 230, 441, 1000, 22, 678, 695, 0, 681]) == 5
	@test lislength([441, 1000, 22, 678, 695, 0, 681, 956, 48, 587, 604, 857, 689, 346, 425, 513, 476, 917, 114, 43, 327, 172, 162, 76, 91, 869, 549, 883, 679, 812, 747, 862, 228, 368, 774, 838, 107, 738, 717, 25, 937, 927, 145, 44, 634, 557, 850, 965]) == 12
end

