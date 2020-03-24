"""
計算オプション選択肢マッパーモジュール
"""
from bpmappers import Mapper, RawField
from typing import Dict, List, Union


class SelectOptions(object):
    """
    計算オプション選択肢を格納するオブジェクト
    """
    def __init__(self, tolerance: List[Dict[str, Union[str, float]]],
                 solver: List[Dict[str, str]]) -> None:
        self.tolerance = tolerance
        self.solver = solver


class SelectOptionsMapper(Mapper):
    """
    計算オプション選択肢マッパーオブジェクト
    """
    tolerance: List[Dict[str, Union[str, float]]] = RawField('tolerance')
    solver: List[Dict[str, str]] = RawField('solver')
