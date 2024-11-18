export QueueItem, ActionQueue, enqueue, dequeue, execute

abstract type QueueItem end

struct ActionQueue
    items::Vector{QueueItem}
end

ActionQueue() = ActionQueue([])

enqueue(queue::ActionQueue, items::QueueItem) = push!(queue.items, items)

dequeue(queue::ActionQueue) = popfirst!(queue.items)

execute(::QueueItem) = error("Not Implemented")