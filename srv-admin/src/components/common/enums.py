from enum import Enum


class ServiceStatus(Enum):
    UP = "UP"
    DOWN = "DOWN"


class ApplicationStatus(Enum):
    OK = "ok"
    BAD = "bad"


class StatusMixin:
    @classmethod
    def get_value(cls, member):
        return cls[member].value[0]
