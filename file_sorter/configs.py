import json


class Configutations:
    configuration = None

    def __init__(self, settings_file) -> None:
        f = open(settings_file)
        Configutations.configuration = json.load(f)
        f.close()

    def get_logging_level() -> str:
        return Configutations.configuration["logging"]["level"]

    def get_logging_file() -> str:
        return Configutations.configuration["logging"]["file"]


def load_configuration(configuration_file: str) -> Configutations:
    return Configutations(configuration_file)
