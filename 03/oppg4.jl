x = [1.0 2.0; 2.0 3.0; 3.0 2.0; 4.0 5.0; 6.0 6.0; 7.0 1.0]

y = [7.0 1.0; 1.0 2.0; 3.0 2.0; 2.0 3.0; 4.0 5.0; 6.0 6.0]

x2 = [5.0 5.0; 5.0 10.0; 5.0 9.0; 5.0 1.0; 5.0 2.0]
y2 = [5.0 1.0; 5.0 2.0; 5.0 5.0; 5.0 9.0; 5.0 10.0]

function splitintwo(x, y)
    len = size(x)[1]
    mid = div(len + 1, 2)

    x_left = x[1:mid, :]
    x_right = x[mid + 1:end, :]

    left_len = size(x_left)[1]
    right_len = size(x_right)[1]

    y_left = similar(x_left)
    y_right = similar(x_right)

    left_it = 1
    right_it = 1

    y_coords_in_left_at_median = Set()
    #  = [row[2] for row in eachrow(x_left) if row[1] == x_left[end, 1]] # if eachrow is defined
    for r in 1:left_len
        if x_left[r, 1] == x_left[end, 1]
            push!(y_coords_in_left_at_median, x_left[r, 2])
        end 
    end

    # If multiple rows have the same x-coord as the median, it should still be placed in the right list
    
    for k = 1:len
        # Place in right if x > split
        # If there is space in left, place it there
        # If not, place in right
        if y[k, 1] > x_left[end, 1]
            y_right[right_it, :] = y[k, :]
            right_it += 1
        elseif y[k, 1] < x_right[1, 1]
            y_left[left_it, :] = y[k, :]
            left_it += 1
        elseif y[k, 2] in y_coords_in_left_at_median && left_it <= left_len
            y_left[left_it, :] = y[k, :]
            left_it += 1
        else
            y_right[right_it, :] = y[k, :]
            right_it += 1
        end
    end
    return x_left, x_right, y_left, y_right
end

# println(splitintwo(x, y))
# println(splitintwo(x2, y2))