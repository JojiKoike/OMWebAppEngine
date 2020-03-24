"""
Web APIリクエストルートマッパーモジュール
"""
from bpmappers import Mapper, DelegateField

from .body.body import RunSimRequestBodyMapper
from .header.header import RequestHeaderMapper


class RunSimulationInputMapper(Mapper):
    """
    シミュレーション実行リクエストマッパーオブジェクト
    """
    head = DelegateField(RequestHeaderMapper)
    body = DelegateField(RunSimRequestBodyMapper)


class RunSimulationRequestMapper(Mapper):
    """
    シミュレーション実行リクエストマッパー
    """
    simulation_input = DelegateField(RunSimulationInputMapper)
