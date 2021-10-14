import pytest

from src.shared.utils.dict_helper import dict_deep_merge


def test_dict_deep_merge():
    d1 = {"user": {"name_first": "test"}, "contract": {"code": "123"}}

    d2 = {"user": {"whatever": "attribute"}, "contract": {"whatever": "attribute"}}

    result = dict_deep_merge(d1, d2)
    assert result == {
        "user": {"name_first": "test", "whatever": "attribute"},
        "contract": {"code": "123", "whatever": "attribute"},
    }
