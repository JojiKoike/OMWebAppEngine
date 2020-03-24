"""
NTTモデルのWeb APIモジュールです。
"""
from .view_base import ViewBase4Modelica


class AirTightEncTemp(ViewBase4Modelica):
    """
    密閉筐体温度計算モデルのREST API実装です。
    """
    def __init__(self, **kwargs):
        kwargs['name'] = __name__
        kwargs['model_name'] = "NTT.modelica_ENC_Unit_Test"
        ViewBase4Modelica.__init__(self, **kwargs)
