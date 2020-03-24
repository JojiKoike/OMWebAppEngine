"""
計算結果オプション設定マッパーモジュール
"""
from typing import List
from bpmappers import Mapper, RawField


class SolutionOptions(object):
    """
    利用可能な計算結果アイテムリストを格納するオブジェクト
    """
    def __init__(self, available_solutions: List[str]) -> None:
        self.available_solutions = available_solutions


class SolutionOptionsMapper(Mapper):
    """
    利用可能な計算結果アイテムリストのJSON-Objectマッパー
    """
    available_solutions: List[str] = RawField()
