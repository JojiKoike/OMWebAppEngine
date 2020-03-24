"""
シミュレーション結果時系列データマッパーモジュール
"""
from typing import List, Dict
from bpmappers import Mapper, RawField


class SimulationResults(object):
    """
    シミュレーション結果（時系列データ）を格納するオブジェクト
    """
    def __init__(self, results: Dict[str, List[float]]) -> None:
        self.results = results


class SimulationResultsMapper(Mapper):
    """
    シミュレーション結果（時系列データ）オブジェクトとJSONを紐づけるマッパーオブジェクト
    """
    results: Dict[str, List[float]] = RawField('results')
