import os
import re

class File:
    def __init__(
            self,
            name: str,
            path: str,
            depth: int,
            file_type: str):
        self.name = name
        self.path = path
        self.depth = depth
        self.file_type = file_type
    
    def __str__(self) -> str:
        return f"{self.name} - {self.depth}"
    
    def __repr__(self) -> str:
        return self.__str__()
    
    def is_duplicate(self) -> bool:
        if len(self.name) < 3:
            return False
        return re.search("\([1-9]+[0-9]*\)$", self.name) is not None

    def build_file(
            root: str,
            name : str,
            depth: str):
        return File(
            name, 
            os.path.join(root, name), 
            depth,
            name.split('.')[-1])

class FileAction:
    def __init__(self, target_file: File) -> None:
        self.target_file = target_file
    
    def execute() -> None:
        pass

class FileActionQueue:
    def __init__(self) -> None:
        self.queue = []