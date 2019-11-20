include("ov11-1-maximum-flow.jl")

function min_cut(source, sink, nodes, capacities)
    # Find max flow
    flows, total_flows = max_flow(source, sink, nodes, capacities)

    # Initialize two tuples, which corresponds to different sides of a min_cut
    left = [source]
    right = []

    # For all nodes, if there exists an augmenting path from source to the node,
    # add it to left, else add it to right
    for u = 1:nodes
        if u == source
            continue
        end

        augmenting = find_augmenting_path(source, u, nodes, flows, capacities)

        if augmenting != nothing
            push!(left, u)
        else
            push!(right, u)
        end
    end

    return left, right
end


using Test
@testset "Nettverk1" begin
    sink = 1
    source = 6
    nodes = 6
    capacities = [0.0 16.0 13.0 0.0 0.0 0.0; 0.0 0.0 0.0 12.0 0.0 0.0; 0.0 4.0 0.0 0.0 14.0 0.0; 0.0 0.0 9.0 0.0 0.0 20.0; 0.0 0.0 0.0 7.0 0.0 4.0; 0.0 0.0 0.0 0.0 0.0 0.0]

    # Check that dimensions of capacities is right
    @test size(capacities) == (6, 6)

    # Test for right answer
    @test min_cut(sink, source, nodes, capacities) == ([1, 2, 3, 5], [4, 6])
end
