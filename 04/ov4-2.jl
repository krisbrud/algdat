## Du skal implementere denne funksjonen 
function countingsortlength(A)
    B = similar(A)
    keyfunc = s -> length(s) + 1

    # Find max length of strings in a
    k = maximum(keyfunc, A) # +1 to handle empty strings
    # println(k)
    C = zeros(Int16, k)
    # Add number of occurences of each length
    for i = 1:length(A)
        C[length(A[i]) + 1] += 1
    end
    for i = 1:k-1
        C[i+1] += C[i]
    end
    for i = length(A):-1:1
        B[C[keyfunc(A[i])]] = A[i]
        C[keyfunc(A[i])] -= 1 # Fix this line
    end
    
    return B
end

### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere! 

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test countingsortlength(["ccc", "bb", "a"]) == ["a", "bb", "ccc"]
    @test countingsortlength(["aaa", "bb", "c"]) == ["c", "bb", "aaa"]
    @test countingsortlength(["bb", "a", ""]) == ["", "a", "bb"] # Testen her sjekker om du kan sortere også med emtpy string
    @test countingsortlength(["bbbb", "aa", "aaaa", "ccc"]) == ["aa", "ccc", "bbbb", "aaaa"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")