from typing import Tuple
import os

from common.functional_programming import reduce_left
from common.logger import Logger
from rules import AbstractRule
import rules
from file import File
from file_actions import FileActionQueue

def build_file_list(directory_path: str, depth: int) -> Tuple[File]:
    files = ()
    for root_path, dir_list, files_list in os.walk(directory_path):
        files = files + build_files_in_directory(
            root_path, dir_list, files_list, depth
        )
    return files

def build_files_in_directory(root: str, dir_list: list, files_list: list, depth: int) -> Tuple[File]:
    files = tuple(map(
        lambda filename: File.build_file(root, filename, depth),
        files_list))
    files_from_the_deep = tuple(map(
        lambda dirname: build_file_list(os.path.join(root, dirname), depth+1),
        dir_list))
    
    return files + reduce_left(
        lambda tuple1, tuple2: tuple1 + tuple2,
        files_from_the_deep,
        ()
    )

def run_file_sorter(directory_path: str, rules_class_names: str) -> None:
    target_files = build_file_list(directory_path, 0)

    rules_classes = []
    for rules_class_name in rules_class_names:
        class_ = getattr(rules, rules_class_name)
        rules_class: AbstractRule = class_()
        rules_classes.append(rules_class)

    queue = FileActionQueue()
    for file in target_files:
        for rule in rules_classes:
            rule.invokate(file, queue)

    queue.execute_actions()
    Logger.info(f'Finished Sorting {directory_path}')