import json


class MockResponse:
    def __init__(self, response_content):
        self.content = response_content


def get_xml_wrapped_string(content: str):
    return f"<wddxPacket version='1.0'><header/><data><string>{content}</string></data></wddxPacket>"


def get_xml_wrapped_json(data: dict):
    return get_xml_wrapped_string(json.dumps(data))