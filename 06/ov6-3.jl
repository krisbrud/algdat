### Du skal implementere denne funksjonen ###
function cumulative(weights)
    weights_dims = size(weights)
    println("weights_dims: $weights_dims")
    pathweights = fill(typemax(Int64), weights_dims)
    # First row of pathweights is trivially equal to that of weights
    pathweights[1,:] = weights[1,:]

    for row = 2:weights_dims[1]
        for col = 1:weights_dims[2]
            for i = -1:1
                try
                    pathweights[row, col] = min(pathweights[row, col], pathweights[row - 1, col + i])
                catch e
                    # Boundserror...
                end
            end
            pathweights[row, col] += weights[row, col]
        end
    end

    return pathweights
end


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test cumulative([1 1 ; 1 1]) == [1 1 ;2 2]
    #Dette er samme eksempel som det vist i oppgaveteskten
	@test cumulative([3  6  8 6 3; 7  6  5 7 3; 4  10 4 1 6; 10 4  3 1 2;6  1  7 3 9])== [3  6  8  6  3;10 9  11 10 6;13 19 13 7  12;23 17 10 8  9;23 11 15 11 17]
end