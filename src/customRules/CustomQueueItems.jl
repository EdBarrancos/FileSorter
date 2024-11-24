import ..FileSorterActionQueue: QueueItem, enqueue, execute

struct PrintQueueItem <: QueueItem
    fileName::String
    toPrint::String
end

execute(item::PrintQueueItem) = println(item.fileName * " - " * item.toPrint)

struct DeleteFile <: QueueItem
    fullpath::String
end

function execute(item::DeleteFile)
    if !isfile(item.fullpath)
        println("Trying to delete non-existant file / a directory: " * item.fullpath)
        return
    end
    println("Deleting " * item.fullpath)
    rm(item.fullpath)
end