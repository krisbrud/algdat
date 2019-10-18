### Du skal implementere denne funksjonen ###
function backtrack(pathweights)
    dims = size(pathweights)
    path = []

    # For the last row, find the index of the smallest weight
    col_val, col_idx = findmin(view(pathweights, dims[1], :))

    # Push this to the path
    push!(path, (dims[1], col_idx))

    for row = dims[1]-1:-1:1
        col = path[end][2]
        next_col = nothing
        curr_min = typemax(Int64)
        for i = -1:1
            try
                if pathweights[row, col + i] < curr_min
                    curr_min = pathweights[row, col + i]
                    next_col = col + i
                end
            catch e
                # Boundserror
            end
        end
        push!(path, (row, next_col))
    end

    return path
end

### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test backtrack([1 1 ; 2 2]) == [(2,1),(1,1)]
    #Dette er samme eksempel som det vist i oppgaveteskten
	@test backtrack([3  6  8  6  3; 10 9  11 10 6; 13 19 13 7  12; 23 17 10 8  9; 23 11 15 11 17]) == [(5,2), (4,3), (3,4), (2,5), (1,5)]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")