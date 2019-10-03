## Du skal implementere denne funksjonen 



# Don't mind me 
function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.
    return character - '`'
end

function countingsortletters(A,position)
    k = 26 # 26 letters in a-z
    
    B = similar(A)
    C = zeros(k) 

    for i = 1:length(A)
        C[chartodigit(A[i][position])] += 1
    end
    for i = 1:k-1
        C[i+1] += C[i] # Make C cumulative
    end
    for i = length(A):-1:1
        B[Int(C[chartodigit(A[i][position])])] = A[i]
        C[chartodigit(A[i][position])] = C[chartodigit(A[i][position])] - 1
    end
    
    return B
end


### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere! 

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test countingsortletters(["aa", "bb", "cc"], 1) == ["aa", "bb", "cc"]
    @test countingsortletters(["cc", "bb", "aa"], 2) == ["aa", "bb", "cc"]
    @test countingsortletters(["ac", "bb", "ca"], 2) == ["ca", "bb", "ac"]
    @test countingsortletters(["ccc", "cba", "ca", "ab", "abc"], 2) == ["ca", "cba", "ab", "abc", "ccc"]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")