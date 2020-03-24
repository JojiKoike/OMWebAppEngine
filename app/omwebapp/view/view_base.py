"""
Web APIの基底クラス群モジュールです。
"""
from typing import List, Dict, Union, Optional
import sys
import traceback
from http import HTTPStatus
from flask import request
from flask_restful import Resource
from OMPython import ModelicaSystem

from ..entity.response.body.results import SimulationResults
from ..entity.request.request import RunSimulationRequestMapper
from ..entity.response.response import UISetValue, UISetValueResponse, \
    UISetValueResponseMapper, SimulationOutput, SimulationResponse, SimulationResponseMapper
from ..entity.response.body.body import UISetValueResponseBody, SimulationResponseBody
from ..entity.response.body.select_options import SelectOptions
from ..entity.response.body.solution_options import SolutionOptions
from ..entity.response.body.default_values import DefaultValues
from ..entity.response.header.header import ResponseHeader
from ..util.logger import get_info_logger
from ..config.constants import TOLERANCE, SOLVER


class ViewBase(Resource):
    """
    Viewの基底クラス
    """
    def __init__(self, **kwargs):
        # Logger初期化処理
        self.logger = get_info_logger(kwargs['name'])


class ViewBase4Modelica(ViewBase):
    """
    Modelica計算APIの基底クラス
    """
    def __init__(self, **kwargs):
        """
        Modelica計算API基底クラスのコンストラクタ
        :param kwargs:
        """
        # 基底クラスの初期化
        ViewBase.__init__(self, **kwargs)

        # 紐づくモデルのModelicaSystemオブジェクト取得
        self.model: ModelicaSystem = kwargs['model']

        # 紐づくモデルのモデル名称を取得
        self.model_name = kwargs['model_name']

        # エラーフラグの初期化
        self.flg_error: bool = False

        # デフォルト値取得
        self.default_sim_options: Optional[Dict[str, Union[str, int, float]]] = kwargs["default_options"]
        self.default_sim_params: Optional[Dict[str, Union[str, int, float]]] = kwargs["default_params"]

        # 取得可能な結果アイテムリスト取得
        self.available_solutions: Optional[List[str]] = kwargs["available_solutions"]

    def get(self):
        """
        画面初期化用設定値を返します
        :return: JSON文字列,  HTTP Response Code
        """

        # Reset Error Flag
        self.flg_error = False

        # Header Section
        head: Dict[str, Union[str, int]] = {
            "index": 0,
            "simulation_model_name": self.model_name,
            "status": "Success" if not self.flg_error else "Failed",
            "version": "1.0.0",
            "data_length": 0
        }
        response_header: ResponseHeader = ResponseHeader(head)

        # Default Values
        default_values: DefaultValues \
            = DefaultValues(self.default_sim_options, self.default_sim_params)

        # Select Options
        select_options: SelectOptions = SelectOptions(TOLERANCE, SOLVER)

        # Solution Options
        solution_options: SolutionOptions = SolutionOptions(self.available_solutions)

        # Response Body
        response_body: UISetValueResponseBody \
            = UISetValueResponseBody(default_values, select_options, solution_options)

        # Unite Header And Body
        ui_set_value: UISetValue = UISetValue(response_header, response_body)
        response: UISetValueResponse = UISetValueResponse(ui_set_value)

        # Serialize
        mapper: UISetValueResponseMapper = UISetValueResponseMapper(response)

        return mapper.as_dict(), \
            HTTPStatus.INTERNAL_SERVER_ERROR if self.flg_error else HTTPStatus.OK

    def post(self):
        """
        計算実行用API定義
        :return: JSON文字列, HTTP Response Code
        """
        # Reset Error Flag
        self.flg_error = False

        # Request JSON 取得
        json_data = request.get_json()
        request_json_dict = RunSimulationRequestMapper(json_data).as_dict()

        # Head
        # Unusedなので一旦コメントアウト
        # head = request_json_dict["simulation_input"]["head"]

        # Body
        body = request_json_dict["simulation_input"]["body"]

        # Simulation Options
        simulation_options: Dict[str, Union[str, float]]  = body["simulation_options"]

        # Parameters
        parameters: Dict[str, float] = body["parameters"]

        # Target Results
        target_results: List[str] = body["results_options"]["target_results"]

        try:
            # Set Simulation Options
            self.model.setSimulationOptions(**simulation_options)

            # Set Simulation Parameters
            self.model.setParameters(**parameters)

            # Execute Calculation
            self.model.simulate()
        except Exception as e:
            self.flg_error = True
            self.logger.error("Error: Failed to run simulation. {0}".format(e))
            sys.stderr.write(traceback.format_exc())

        # Generate Result Object
        # Body
        results: Optional[Dict[str, List[float]]] = \
            {key.replace(".", "_").replace("[", "").replace("]", ""):
                self.model.getSolutions(key).tolist() for key in target_results}
        simulation_results: SimulationResults = SimulationResults(results)
        response_body: SimulationResponseBody = SimulationResponseBody(simulation_results)

        # Head
        header_values: Dict[str, Union[str, int]] = {
            "index": 0,
            "simulation_model_name": self.model_name,
            "status": "Success" if not self.flg_error else "Failed",
            "version": "1.0.0",
            "data_length": 0 if results is None else len(results[target_results[0]])
        }
        response_header: ResponseHeader = ResponseHeader(header_values)

        # Unite Head and Body
        output: SimulationOutput = SimulationOutput(response_header, response_body)
        response: SimulationResponse = SimulationResponse(output)

        # Serialize
        mapper: SimulationResponseMapper = SimulationResponseMapper(response)

        return mapper.as_dict(), \
            HTTPStatus.INTERNAL_SERVER_ERROR if self.flg_error else HTTPStatus.CREATED
