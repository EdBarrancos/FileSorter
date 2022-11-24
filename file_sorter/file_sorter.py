import sys

from logger import Logger
from configs import load_configuration

if __name__ == "__main__":
    CONFIG_FILE = "settings/settings.json"

    load_configuration(CONFIG_FILE)

    Logger.info("File Sorter Initiated")
