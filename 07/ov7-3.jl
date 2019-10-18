include("ov7-1.jl")
include("ov7-2.jl")

function mincoinsdynamic(coins, value)
    subsol = fill(typemax(Int), value)

    for i = 1:value
        if i in coins
            subsol[i] = 1
        end
    end

    println("subsol $subsol")
    
    for i = 2:value
        if subsol[i] != 1
            subsol[i] = minimum(subsol[j] + subsol[i-j] for j = 1:i-1)
        end
    end

    return subsol[end]
end

function mincoins(coins, value)
    if usegreed(coins)
        return mincoinsgreedy(coins, value)
    end
    return mincoinsdynamic(coins, value)
end

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester 7-3\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
    @test mincoins([4,3,1],18) == 5
    @test mincoins([1000,500,100,30,7,1],14) == 2
    @test mincoins([40, 30, 20, 10, 1], 90) == 3
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")