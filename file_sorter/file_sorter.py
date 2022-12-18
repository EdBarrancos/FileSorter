from common.logger import Logger
from common.configs import load_configuration

import argparse

if __name__ == "__main__":
    CONFIG_FILE = "settings/settings.json"

    load_configuration(CONFIG_FILE)

    Logger.info("File Sorter Initiated")

    parser = argparse.ArgumentParser()
    parser.add_argument('directory', type=str,
                        help="Which Directory do you want to filter and sort?"
                        + "[Full file path]")
    parser.add_argument('--rules', type=str,
                        help="Path to the rules file")
    opt = parser.parse_args()
