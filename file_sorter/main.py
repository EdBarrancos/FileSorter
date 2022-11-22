from logger import Logger
from configs import load_configuration

CONFIG_FILE = "settings/file_sorter_properties.json"

load_configuration(CONFIG_FILE)

Logger.info("File Sorter Initiated")
