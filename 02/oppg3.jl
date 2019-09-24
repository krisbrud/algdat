mutable struct NodeDoublyLinked
    prev::Union{NodeDoublyLinked, Nothing} # Er enten forrige node eller nothing
    next::Union{NodeDoublyLinked, Nothing} # Er enten neste node eller nothing
    value::Int # Verdien til noden
end

function maxofdoublelinkedlist(linkedlist)
    # iterate forwards from node, then backwards
    m = linkedlist.value
    it = linkedlist
    while it != nothing
        if it.value > m
            m = it.value
        end
        it = it.next
    end

    it = linkedlist

    while it != nothing
        if it.value > m
            m = it.value
        end
        it = it.prev
    end

    return m
end