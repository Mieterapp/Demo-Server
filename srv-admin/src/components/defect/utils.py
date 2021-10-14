import os
from uuid import uuid4


def get_defect_image_dir_path(instance, filename) -> str:
    """
    Return defect directory
    :param instance: thumbnail
    :param filename: origin filename
    :return: new filename
    """
    filename = uuid4().hex + os.path.splitext(filename)[1]
    path = "defect/%s" % filename.lower()
    return path


def get_defect_type_image_dir_path(instance, filename) -> str:
    """
    Return photo directory
    :param instance: thumbnail
    :param filename: origin filename
    :return: new filename
    """
    filename = uuid4().hex + os.path.splitext(filename)[1]
    path = "defect_type/%s" % filename.lower()
    return path
