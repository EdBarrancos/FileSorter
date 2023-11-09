import os

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


def build_file(
        root: str,
        name : str,
        depth: str):
    return File(
        name, 
        os.path.join(root, name), 
        depth,
        name.split('.')[-1])