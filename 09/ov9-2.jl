#include("ov9-1.jl")

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
