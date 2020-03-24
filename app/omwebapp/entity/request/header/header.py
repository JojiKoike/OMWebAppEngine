"""
計算リクエストヘッダー部マッパーモジュール
"""
from bpmappers import Mapper, RawField


class RequestHeaderMapper(Mapper):
    """
    リクエストのヘッダー部の値を格納するマッパーオブジェクト
    """
    index: int = RawField('index')
    simulation_model_name: str = RawField('simulation_model_name')
    version: str = RawField('version')
