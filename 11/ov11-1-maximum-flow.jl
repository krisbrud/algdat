using DataStructures: Queue, enqueue!, dequeue!

#Tilgjengelige funksjoner
function find_augmenting_path(source, sink, nodes, flows, capacities)

    function create_path(source, sink, parent)
      # creates a path from source to sink using parent list
        node = sink
        path = Vector{Int}([sink])
        while node ≠ source
            node = parent[node]
            push!(path, node)
        end
        return reverse(path)
    end
  
    discovered = zeros(Bool, nodes)
    parent = zeros(Int, nodes)
    queue = Queue{Int}()
    enqueue!(queue, source)
  
    # BFS to find augmenting path, while keeping track of parent nodes
    while !isempty(queue)
        node = dequeue!(queue)
        if node == sink
            return create_path(source, sink, parent)
        end
  
        for neighbour ∈ 1:nodes
            if !discovered[neighbour] && flows[node, neighbour] < capacities[node, neighbour]
                enqueue!(queue, neighbour)
                discovered[neighbour] = true
                parent[neighbour] = node
            end
        end
    end
  
    return nothing # no augmenting path found
end
  
function max_path_flow(path, flows, capacities)
    # find max flow to send through a path
    n = length(path)
    flow = Inf
    for i in 2:n
        u, v = path[i - 1], path[i]
        flow = min(flow, capacities[u, v] - flows[u, v])
    end
    return flow
end
  
function send_flow!(path, flow, flows)
    n = length(path)
    for i in 2:n
        u, v = path[i - 1], path[i]
        flows[u, v] += flow
        flows[v, u] -= flow
    end
end
  #Tilgjengelige funksjoner slutt
  
function max_flow(source, sink, nodes, capacities)
    flows = zeros(size(capacities))

    augmenting = find_augmenting_path(source, sink, nodes, flows, capacities)

    while augmenting != nothing
        flow = max_path_flow(augmenting, flows, capacities)
        send_flow!(augmenting, flow, flows)
        augmenting = find_augmenting_path(source, sink, nodes, flows, capacities)        
    end

    # When the loop is finished, the total flow must equal the flow into the sink
    total_flows = 0
    
    for u = 1:nodes
        total_flows += flows[u, sink]
    end

    return flows, total_flows
end