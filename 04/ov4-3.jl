## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv
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

## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv
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

function firstwithminimumlength(A, minlength)
    # Returns index of first string with length at least minlength
    return findfirst(s -> length(s) >= minlength, A)
end

function laststwithminimumlength(A, minlength)
    # Returns the index last string longer than minlength
    index = findfirst(s -> length(s) < minlength, A)
    return index != nothing ? index - 1 : nothing
end

function flexradix(A, maxlength)
    B = countingsortlength(A) # Also copies the list, so the sorting is not inplace
    println("B: $(B)")

    len = length(B)

    intervals = []

    for i = 1:maxlength
        println("i $i")
        # Find intervals that need to be sorted by the character
        first = firstwithminimumlength(B, i)
        println("first, $first")
        last = laststwithminimumlength(view(B, first:length(B)), i)
        if last === nothing && length(B[end]) >= i
            last = length(B)
            println("last, $last")
        end

        while first != nothing && last != nothing
            println("pushing first, last = $first, $last")
            push!(intervals, [first, last])
            first = firstwithminimumlength(view(B, last + 1:len), i)
            if first != nothing
                last = laststwithminimumlength(view(B, first:len), i)
            end
        end

        while length(intervals) != 0
            first, last = pop!(intervals)
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