# General implementation of Djikstra's algorithm

using DataStructures: PriorityQueue, enqueue!, dequeue!

# Type definitions
mutable struct Node
    name::String # used to distinguish nodes when debugging
    d::Union{Float64,Nothing} # d for distance
    p::Union{Node,Nothing} # p for predecessor
end
Node(name) = Node(name, nothing, nothing) # constructor used for naming nodes

mutable struct Graph
    V::Array{Node} # V for Vertices
    Adj::Dict{Node,Array{Node}} # Adj for Adjacency
end

function general_dijkstra!(G, w, s, reverse = false)
    # G: Graph
    # w: dictionary, (u, v) => weight
    # s: start, element in G to take into account. Will always have attribute name == 'A'
    # reverse: should the algorithm prefer the lightest or heaviest path?
    initialize!(G, s)

    if reverse
        Q = PriorityQueue(Base.Order.Reverse, u => u.d for u in G.V)
    else
        Q = PriorityQueue(u => u.d for u in G.V)
    end

    while !isempty(Q)
        # When dequeueing u, we know that it must have it's final distance and predecessor,
        # as we disallow negative edges
        u = dequeue!(Q)
        for v in G.Adj[u]
            update!(u, v, w) # Usually relaxing the edge

            if haskey(Q, v) # Also need to update the distance to sort by in the priority queue
                Q[v] = v.d
            end
        end
    end
end