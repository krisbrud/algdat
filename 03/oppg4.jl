x = [1.0 2.0; 2.0 3.0; 3.0 2.0; 4.0 5.0; 6.0 6.0; 7.0 1.0]

y = [7.0 1.0; 1.0 2.0; 3.0 2.0; 2.0 3.0; 4.0 5.0; 6.0 6.0]

function rowisinarray(arr, row)
    # num_cols = size(arr)[1]
    num_cols = 2

    return any([row' == arr[i, :] for i in 1:num_cols])
end

function splitintwo(x, y)
    len = size(x)[1]
    mid = div(len + 1, 2)

    x_left = x[1:mid, :]
    x_right = x[mid + 1:end, :]

    left_len = size(x_left)[1]
    right_len = size(x_right)[1]

    println(len)
    println(x_left)
    println(x_right)

    y_left = similar(x_left)
    y_right = similar(x_right)

    left_it = 1
    right_it = 1
    
    for k = 1:len
        # Place in right if x > split
        # If there is space in left, place it there
        # If not, place in right
        if y[k, 1] > x_left[end, 1]
            y_right[right_it, :] = y[k, :]
            right_it += 1
        elseif left_it <= left_len
            y_left[left_it, :] = y[k, :]
            left_it += 1
        else
            y_right[right_it, :] = y[k, :]
            right_it += 1
        end
    end
    return x_left, x_right, y_left, y_right
end

println(splitintwo(x, y))