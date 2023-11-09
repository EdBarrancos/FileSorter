import os

class UtilsFileSystem:
    def create_path_to_file_if_not_exist(file_path: str):
        path_to_file = "/".join(file_path.split("/")[0:-1])
        if not os.path.exists(path_to_file):
            os.makedirs(path_to_file)
            print("Creating dirs", path_to_file)