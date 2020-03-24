"""
シミュレーション実行リクエストボディマッパーモジュール
"""
from typing import List, Dict, Union
from bpmappers import Mapper, RawField


class RunSimRequestBodyMapper(Mapper):
    """
    シミュレーションリクエストボディマッパーオブジェクト
    """
    simulation_options: Dict[str, Union[float, str]] = RawField('simulation_options')
    parameters: Dict[str, float] = RawField('parameters')
    results_options: Dict[str, List[str]] = RawField('results_options')
