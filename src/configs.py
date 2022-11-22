import json


class Configutations:
    def __init__(self, settings_file) -> None:
        f = open(settings_file)
        self.data = json.load(f)
        f.close()

    def get_logging_level(self) -> str:
        return self.data["logging"]["level"]

    def get_logging_file(self) -> str:
        return self.data["logging"]["file"]


def create_configuration(configuration_file: str) -> Configutations:
    return Configutations(configuration_file)
