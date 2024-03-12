from file import File
from file_actions import FileActionQueue, DeleteFileAction

class AbstractRule:
    def invokate(self, file: File, queue: FileActionQueue) -> None:
        pass

""" Add your rules here """

class DeleteDuplicateRule(AbstractRule):
    def invokate(self, file: File, queue: FileActionQueue) -> None:
        if file.is_duplicate():
            queue.queue_action(DeleteFileAction(file))

class PrintName(AbstractRule):
    def invokate(self, file: File, queue: FileActionQueue):
        print(file.name)

