from file import File

class AbstractRule:
    def invokate(self, file: File):
        pass

""" Add your rules here """

class PrintName(AbstractRule):
    def invokate(self, file: File):
        print(file.name)

