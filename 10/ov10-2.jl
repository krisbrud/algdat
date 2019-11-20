function initialize!(G, s)
    # Initialization function for widest path
    for i = 1:length(G.V)
        G.V[i].p = nothing
        G.V[i].d = -typemax(Float64)
    end

    s.d = typemax(Float64)
end

function update!(u, v, w)
    # Widest path update funciton
    # Want to find the path with the highest minimum weight/bandwidth
    # to the node
    alt = min(u.d, w[(u, v)])

    if v.d < alt
        v.d = alt
        v.p = u
    end
end