"""
HTTPレスポンスのJSONとオブジェクトのマッパー群モジュール
"""
from bpmappers import Mapper, DelegateField
from .header.header import ResponseHeaderMapper, ResponseHeader
from .body.body import UISetValueResponseBody, UISetValueResponseBodyMapper, \
    SimulationResponseBody, SimulationResponseBodyMapper


class SimulationOutput(object):
    """
    シミュレーションレスポンスオブジェクト
    """
    def __init__(self, head: ResponseHeader, body: SimulationResponseBody) -> None:
        self.head = head
        self.body = body


class SimulationOutputMapper(Mapper):
    """
    シミュレーションレスポンスオブジェクトとJSONを紐づけるマッパーオブジェクト
    """
    head = DelegateField(ResponseHeaderMapper, attach_parent=True)
    body = DelegateField(SimulationResponseBodyMapper)


class SimulationResponse(object):
    """
    シミュレーションレスポンスルートオブジェクト
    """
    def __init__(self, simulation_output: SimulationOutput):
        self.simulation_output = simulation_output


class SimulationResponseMapper(Mapper):
    """
    シミュレーションレスポンスルートマッパー
    """
    simulation_output = DelegateField(SimulationOutputMapper)


class UISetValue(object):
    """
    画面初期化パラメータレスポンスオブジェクト
    """
    def __init__(self, head: ResponseHeader, body: UISetValueResponseBody):
        self.head = head
        self.body = body


class UISetValueMapper(Mapper):
    """
    画面初期化パラメータレスポンスマッパーオブジェクト
    """
    head = DelegateField(ResponseHeaderMapper, attach_parent=True)
    body = DelegateField(UISetValueResponseBodyMapper)


class UISetValueResponse(object):
    """
    画面初期化パラメータレスポンスルートオブジェクト
    """
    def __init__(self, ui_set_value: UISetValue):
        self.ui_set_value = ui_set_value


class UISetValueResponseMapper(Mapper):
    """
    画面初期化パラメータレスポンスルートマッパー
    """
    ui_set_value = DelegateField(UISetValueMapper)
