function floyd_warshall(adjacency_matrix, nodes, f, g)
    n = size(adjacency_matrix)[1]

    for k = 1:n

        for i = 1:n
            for j = 1:n
                adjacency_matrix[i, j] = f(adjacency_matrix[i, j], g(adjacency_matrix[i, k], adjacency_matrix[k, j]))
            end
        end
    end

    return adjacency_matrix
end