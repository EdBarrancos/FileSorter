from file import File
from common.logger import Logger

class FileAction:
    def __init__(self, target_file: File) -> None:
        self.target_file = target_file
    
    def execute(self) -> None:
        pass

class DeleteFileAction(FileAction):
    def execute(self) -> None:
        self.target_file.delete()
        Logger.info(f'Deleting {self.target_file.full_name()}')
    

class FileActionQueue:
    def __init__(self) -> None:
        self.queue = []
    
    def queue_action(self, new_action: FileAction):
        self.queue.append(new_action)
        return self

    def execute_actions(self):
        for action in self.queue:
            action.execute()