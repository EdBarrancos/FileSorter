import os
import argparse

from common.logger import Logger
from common.configs import load_configuration, setup_log_file
from file_sorter import run_file_sorter



def directory(path: str):
    if os.path.isdir(path):
        return path

    raise ValueError(f'{path} is not a valid directory')


if __name__ == "__main__":
    CONFIG_FILE = "settings/settings.json"

    load_configuration(CONFIG_FILE)
    setup_log_file()

    Logger.info("File Sorter Initiated")

    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--directory',
                        metavar="Full path of directory",
                        required=True,
                        type=directory,
                        help="Which Directory do you want to filter and sort?"
                        + "[Full file path]")
    parser.add_argument('-r', '--rules',
                        metavar="Full path of rules file",
                        required=True,
                        type=argparse.FileType('w'),
                        help="Path to the rules file")
    opt = parser.parse_args()

    Logger.info("Command line arguments parsed")
    Logger.debug(f'Parsed: {opt}')

    run_file_sorter(opt.directory, opt.rules)
