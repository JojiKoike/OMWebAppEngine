"""
デフォルト値レスポンスボディマッパーモジュール
"""
from typing import Dict, Union
from bpmappers import Mapper, RawField


class DefaultValues(object):
    """
    デフォルト値を格納するオブジェクト
    """
    def __init__(self,
                 simulation_options: Dict[str, Union[float, str]],
                 parameters: Dict[str, float]) -> None:
        self.simulation_options = simulation_options
        self.parameters = parameters


class DefaultValuesMapper(Mapper):
    """
    デフォルト値マッパーオブジェクト
    """
    simulation_options: Dict[str, Union[float, str]] = RawField('simulation_options')
    parameters: Dict[str, float] = RawField('parameters')
