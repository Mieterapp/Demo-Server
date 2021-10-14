import os
from uuid import uuid4


def get_prefixed_path(instance, filename) -> str:
    prefix = instance.__class__.__name__.lower()
    filename = uuid4().hex + os.path.splitext(filename)[1]
    path = f"{prefix}/{filename.lower()}"
    return path
