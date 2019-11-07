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
    sort!(E)       # Sort edges in increasing order by weight

    num_edges = 0  # Number of edges included so far
    i = 1          # Current iterator index in E

    nodes = [DisjointSetNode() for i = 1:n]
    
    # For every edge (in increasing order by weight), include the edge in our solution
    # iff the nodes are not part of the same set 

    while num_edges < n - k
        w, u, v = E[i]
        if findset(nodes[u]) != findset(nodes[v])
            union!(nodes[u], nodes[v])
            num_edges += 1
        end
        i += 1
    end

    # We have now picked the k lightest edges without creating a cycle.
    # It may still be that all n nodes are not connected by an edge to another node
    # However, nodes[] represent which nodes should be connected in the cluster

    clusters = [[] for _ in 1:k]
    set_indices = [] # indicies of a member of non-empty cluster in nodes

    for i = 1:n  # For every node i
        inserted = false
        for j = 1:length(set_indices) # Check if the new node exist in an existing cluster
            if findset(nodes[set_indices[j]]) == findset(nodes[i])
                # Node belongs to cluster, include it there
                push!(clusters[j], i)
                inserted = true
                break
            end
        end

        if !inserted
            # Node does not belong to any previous cluster, include it in the next cluster
            # Make node i a representative of the cluster by adding it to set_indices
            push!(set_indices, i)

            # Include i in the cluster at the new index
            push!(clusters[length(set_indices)], i)
        end
    end

    println("clusters: $clusters")
    
    return clusters
end
   
# printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)


# using Test
# @testset "Tester" begin
#     @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
#     (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 2)]) == sort([[1, 2], [3, 4]])
#     @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
#     (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 3)]) == sort([[1], [2], [3, 4]])
# end

# println("\nFungerte det? Prøv å kjør koden i inginious!")
# println("Husk at disse testene ikke sjekker alle grensetilfellene")
# println("---------------------------------------------------------\n\n")