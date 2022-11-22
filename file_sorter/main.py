from logger import get_logger
from configs import create_configuration

CONFIG_FILE = "settings/file_sorter_properties.json"

configuration = create_configuration()
logger = get_logger(__name__)

logger.INFO("File Sorter Initiated")
