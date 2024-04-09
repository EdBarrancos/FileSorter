from file import File, since_modified
from file_actions import FileActionQueue, DeleteFileAction

class AbstractRule:
    def invokate(self, file: File, queue: FileActionQueue) -> None:
        pass

""" Add your rules here """

class DeleteDuplicateRule(AbstractRule):
    def invokate(self, file: File, queue: FileActionQueue) -> None:
        if file.is_duplicate():
            queue.queue_action(DeleteFileAction(file))

class DeleteDebFileRule(AbstractRule):
    def invokate(self, file: File, queue: FileActionQueue) -> None:
        if file.file_type == "deb":
            queue.queue_action(DeleteFileAction(file))

class DeleteOlderThanEightMonthsRule(AbstractRule):
    def invokate(self, file: File, queue: FileActionQueue) -> None:
        types_to_delete = ["zip", "snap", "mp4", "png"]
        days_to_delete = 8 * 30
        if file.file_type in types_to_delete and since_modified(file).days >= days_to_delete:
            queue.queue_action(DeleteFileAction(file))

class PrintName(AbstractRule):
    def invokate(self, file: File, queue: FileActionQueue):
        print(file.name)

