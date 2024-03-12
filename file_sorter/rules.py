from file import File, FileActionQueue

class AbstractRule:
    def invokate(self, file: File, queue: FileActionQueue) -> None:
        pass

""" Add your rules here """

class PrintName(AbstractRule):
    def invokate(self, file: File, queue: FileActionQueue):
        print(file.name)

