# include("ov9-1.jl")
# include("ov9-2.jl")
#include("ov9-3.jl")

# From 9-1:
mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end

function findset(x)
    if x != x.p
        x.p = findset(x.p)
    end

    return x.p
end

# From 9-2:
function link!(x, y)
    if x.rank > y.rank 
        y.p = x
    else x.p = y
        if x.rank == y.rank
            y.rank += 1
        end
    end
end

function union!(x, y)
    link!(findset(x), findset(y))
end

# 9-4
function findclusters(E, n, k)
    sort!(E) # Sort edges in increasing order by weight

    num_edges = 0  # Number of edges included in the MST so far
    i = 1          # Current index in E

    nodes = [DisjointSetNode() for i = 1:n]
    edges = []
    
    while num_edges <= k
        w, u, v = E[i]
        if findset(nodes[u]) != findset(nodes[v])
            union!(nodes[u], nodes[v])
            push!(edges, E[i])
            num_edges += 1
        end
        i += 1
    end
    
    # The nodes are now connected in the clusters specified by 'nodes'
    # and the edges by 'edges'

    clusters = [[] for _ in 1:k]
    set_indices = []

    # println("nodes $nodes")
    # println("edges $edges")
    
    for i = 1:length(edges)
        # println("i $i")
        # Fill the clusters consecutively with the edges
        # Every edge should be placed in 
        for j in 1:length(clusters)
            if length(clusters[j]) == 0
                # Empty cluster, insert the node
                w, u, v = edges[i]
                push!(set_indices, i)
                break
            elseif findset(nodes[i]) == findset(nodes[set_indices[j]])
                push!(clusters[j], edges[i])
                break
            end
        end
    end
    println("clusters $clusters")
    # println("set_indices $set_indices")
    
    return clusters
end
   
printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)


using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 2)]) == sort([[1, 2], [3, 4]])
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 3)]) == sort([[1], [2], [3, 4]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")