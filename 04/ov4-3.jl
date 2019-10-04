## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv
function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.
    return character - '`'
end

function countingsortletters(A, position)
    k = 26 # 26 letters in a-z
    
    B = similar(A)
    C = zeros(k) 

    for i = 1:length(A)
        C[chartodigit(A[i][position])] += 1
    end
    for i = 1:k - 1
        C[i + 1] += C[i] # Make C cumulative
    end
    for i = length(A):-1:1
        B[Int(C[chartodigit(A[i][position])])] = A[i]
        C[chartodigit(A[i][position])] = C[chartodigit(A[i][position])] - 1
    end
    
    return B
end

## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv
function countingsortlength(A)
    B = similar(A)
    keyfunc = s->length(s) + 1

    # Find max length of strings in a
    k = maximum(keyfunc, A) # +1 to handle empty strings
    # println(k)
    C = zeros(Int16, k)
    # Add number of occurences of each length
    for i = 1:length(A)
        C[length(A[i]) + 1] += 1
    end
    for i = 1:k - 1
        C[i + 1] += C[i]
    end
    for i = length(A):-1:1
        B[C[keyfunc(A[i])]] = A[i]
        C[keyfunc(A[i])] -= 1
    end
    
    return B
end

# Pseudo
# Sorter på lengde først
# Sorter så alle delintervaller på første bokstav, andre bokstav osv.
# Mulige optimaliseringer:
#   Hold styr på laveste og høyeste index gitt strenglengde
#   Bruk en indexfunksjon

function intervalswithminlength(A, minlength)
    intervals = []
    in_sequence = false
    first = nothing
    
    for i = 1:length(A)-1
        if in_sequence
            if length(A[i+1]) < minlength
                # End of sequence
                in_sequence = false
                if i > first # length at least two
                    push!(intervals, [first, i])
                end
            end
        elseif length(A[i]) >= minlength
            in_sequence = true
            first = i
        end
    end

    if in_sequence
        # last element of A is part of sequence
        push!(intervals, [first, length(A)])
    end

    return intervals
end

function flexradix(A, maxlength)
    B = countingsortlength(A) # Also copies the list, so the sorting is not inplace

    for i = maxlength:-1:1
        intervals = intervalswithminlength(B, i)
        for (first, last) in intervals # Unpack tuples
            B[first:last] = countingsortletters(view(B, first:last), i)
        end
    end

    return B
end





### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere! 

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test flexradix(["d", "c", "b", "a"], 1) == ["a", "b", "c", "d"]
    @test flexradix(["d", "c", "b", ""], 1) == ["", "b", "c", "d"]
    @test flexradix(["jeg", "elsker", "deg"], 6) == ["deg", "elsker", "jeg"]
    @test flexradix(["denne", "oppgaven", "mangler", "emojies"], 8) == ["denne", "emojies", "mangler", "oppgaven"]
    @test flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6) == ["agg", "aggie", "hyblen", "kobra", "kort"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")