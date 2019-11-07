include("ov9-3.jl")
include("ov9-4.jl")


#= 
    Generere listen, E, med kanter, der vekten, w, regnes ut med funksjonen hammingdistance. Husk at det skal gå en kant mellom et hvert par med noder.
    Finne grupperingen med findclusters.
    Endre returverdien fra findclusters til å innholde lister med dyrenavn i stedet for indekser.
=#

function findanimalgroups(animals, k)
    edges = []
    len = length(animals)

    # Populate edges
    for i = 1:len
        for j = i:len
            if i != j
                push!(edges, (hammingdistance(animals[i][2], animals[j][2]), i, j))
            end
        end
    end

    # Group indices of clusters
    clusters = findclusters(edges, len, k)

    # Map indices to animal names
    animal_clusters = [map(idx -> animals[idx][1], cluster) for cluster in clusters]

    return animal_clusters
end


using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findanimalgroups([("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")], 2)]) == sort([["Ugle"], ["Elg", "Hjort"]])

    @test sort([sort(x) for x in findanimalgroups([("Hval", "CGCACATA"), ("Ulv", "AGAAACCT"), ("Delfin", "GGCACATA"), ("Hund", "GGAGACAA"), 
    ("Katt", "TAACGCCA"), ("Leopard", "TAACGCCT")], 3)]) == sort([["Hund", "Ulv"], ["Delfin", "Hval"], ["Katt", "Leopard"]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")
