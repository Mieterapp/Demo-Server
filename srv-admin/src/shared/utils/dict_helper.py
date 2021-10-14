import json


def dict_deep_merge(dict_source: dict, dict_dest: dict):
    """
    run me with nosetests --with-doctest file.py

    >>> a = { 'first' : { 'all_rows' : { 'pass' : 'dog', 'number' : '1' } } }
    >>> b = { 'first' : { 'all_rows' : { 'fail' : 'cat', 'number' : '5' } } }
    >>> merge(b, a) == { 'first' : { 'all_rows' : { 'pass' : 'dog', 'fail' : 'cat', 'number' : '5' } } }
    True
    """
    for key, value in dict_source.items():
        if isinstance(value, dict):
            # get node or create one
            node = dict_dest.setdefault(key, {})
            dict_deep_merge(value, node)
        else:
            dict_dest[key] = value

    return dict_dest