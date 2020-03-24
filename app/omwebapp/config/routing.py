"""
ルーティング設定に関するモジュールです。
"""

from typing import Dict, Union, List
from flask_restful import Api
from OMPython import ModelicaSystem
from .constants import DEFAULT_OPTIONS_POSTFIX, DEFAULT_PARAMS_POSTFIX, AVAILABLE_SOLUTIONS_POSTFIX
from ..view.hello import HelloWorld
from ..view.create_model import CreateModel
from ..view.edit_model import EditModel
from ..view.simplemsd import SimpleMSD
from ..view.ntt import AirTightEncTemp


# Routing Configuration
def configure_routing(api: Api,
                      model_map: Dict[str, ModelicaSystem],
                      default_input_values_map: Dict[str, Dict[str, Union[str, int, float]]],
                      available_solutions_map: Dict[str, List[str]]) -> None:
    """
    ルーティングの設定を行います
    :param api: Apiオブジェクト
    :param model_map: 計算対象モデル名とModelicaSystemオブジェクトのマップ
    :param default_input_values_map: 各モデルのオプション、パラメータデフォルト値のマップ
    :param available_solutions_map: 各モデルの利用可能な結果アイテムリストのマップ
    :return: None
    """
    # Routing Configuration
    api.add_resource(HelloWorld, '/hello')
    api.add_resource(CreateModel, "/createmodel")
    api.add_resource(EditModel, "/editmodel")
    api.add_resource(SimpleMSD, '/simplemsd',
                     resource_class_kwargs=
                     {'model': None if model_map is None else model_map['SimpleMSD'],
                      'default_options': None if default_input_values_map is None
                                else default_input_values_map['SimpleMSD' + DEFAULT_OPTIONS_POSTFIX],
                      'default_params': None if default_input_values_map is None
                                else default_input_values_map['SimpleMSD' + DEFAULT_PARAMS_POSTFIX],
                      'available_solutions': None if available_solutions_map is None
                                else available_solutions_map["SimpleMSD" + AVAILABLE_SOLUTIONS_POSTFIX]})
    api.add_resource(AirTightEncTemp, '/ntt/airtightenctemp',
                     resource_class_kwargs=
                     {'model': None if model_map is None else
                         model_map['NTT.modelica_ENC_Unit_Test'],
                      'default_options': None if default_input_values_map is None
                      else default_input_values_map['NTT.modelica_ENC_Unit_Test' + DEFAULT_OPTIONS_POSTFIX],
                      'default_params': None if default_input_values_map is None
                      else default_input_values_map['NTT.modelica_ENC_Unit_Test' + DEFAULT_PARAMS_POSTFIX],
                      'available_solutions': None if available_solutions_map is None
                      else available_solutions_map['NTT.modelica_ENC_Unit_Test' + AVAILABLE_SOLUTIONS_POSTFIX]})
