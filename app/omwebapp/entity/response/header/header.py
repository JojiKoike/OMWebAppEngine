from typing import Dict, Union
from bpmappers import Mapper, RawField


class ResponseHeader(object):
    """
    レスポンスのヘッダー部の値を格納するオブジェクト
    """
    def __init__(self, head: Dict[str, Union[str, int]]) -> None:
        self.head = head


class ResponseHeaderMapper(Mapper):
    """
    レスポンスのヘッダー部のオブジェクトとJSONを紐づけるマッパーオブジェクト
    """
    head: Dict[str, Union[str, int]] = RawField()
