function mincoinsgreedy(coins, value)
    # Velg alltid så mange mynter som mulig - grådig valg
    total_coins = 0

    for i = 1:length(coins)
        @inbounds num_coins = div(value, coins[i])
        @inbounds value -= num_coins * coins[i]
        total_coins += num_coins
    end

    return total_coins
end

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoinsgreedy([1000,500,100,20,5,1],1226) == 6
  @test mincoinsgreedy([20,10,5,1],99) == 10
  @test mincoinsgreedy([5,1],133) == 29
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")