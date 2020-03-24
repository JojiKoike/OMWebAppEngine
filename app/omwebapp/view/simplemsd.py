"""
1次元バネマスダンパ系モデルのAPI実装モジュールです。
"""
from .view_base import ViewBase4Modelica


class SimpleMSD(ViewBase4Modelica):
    """
    1次元バネマスダンパ系モデルのREST API実装です。
    """
    def __init__(self, **kwargs):
        kwargs['model_name'] = "SimpleMSD"
        kwargs['name'] = __name__
        ViewBase4Modelica.__init__(self, **kwargs)
