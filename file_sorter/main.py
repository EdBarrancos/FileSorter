from file_sorter.logger import get_logger
from file_sorter.configs import create_configuration

CONFIG_FILE = "settings/file_sorter_properties.json"

configuration = create_configuration(CONFIG_FILE)
logger = get_logger(__name__, configuration)

logger.info("File Sorter Initiated")
