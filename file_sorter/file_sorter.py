from typing import Tuple
import os
from common.functional_programming import reduce_left

from file import File, build_file

def build_file_list(directory_path: str, depth: int) -> Tuple[File]:
    files = ()
    for root_path, dir_list, files_list in os.walk(directory_path):
        files = files + build_files_in_directory(
            root_path, dir_list, files_list, depth
        )
    return files

def build_files_in_directory(root: str, dir_list: list, files_list: list, depth: int) -> Tuple[File]:
    files = tuple(map(
        lambda filename: build_file(root, filename, depth),
        files_list))
    files_from_the_deep = tuple(map(
        lambda dirname: build_file_list(os.path.join(root, dirname), depth+1),
        dir_list))
    
    return files + reduce_left(
        lambda tuple1, tuple2: tuple1 + tuple2,
        files_from_the_deep,
        ()
    )

def run_file_sorter(directory_path: str, rules_path: str):
    print(build_file_list(directory_path, 0))