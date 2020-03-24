import unittest
import json
from typing import List, Dict, Union, Optional

from app.omwebapp.entity.response.body.solution_options import SolutionOptions
from app.omwebapp.entity.response.body.default_values import DefaultValues
from app.omwebapp.entity.response.body.select_options import SelectOptions
from app.omwebapp.entity.response.header.header import ResponseHeader
from app.omwebapp.entity.response.body.body import SimulationResponseBody, UISetValueResponseBody
from app.omwebapp.entity.response.body.results import SimulationResults
from app.omwebapp.entity.response.response import SimulationResponseMapper, \
    SimulationOutput, SimulationResponse, UISetValue, UISetValueResponse, \
    UISetValueResponseMapper


class SimpleMSDResponseTestCase(unittest.TestCase):

    def test_response_ui_set_values_simple_msd_normal(self):
        """
        １次元バネマスダンパモデルの画面初期化設定値マッパーテスト：正常系
        :return: None
        """
        # Build Response Objects

        # Response Header
        head_values: Dict[str, Union[str, int]] = {
            "index": 0,
            "simulation_model_name": "SimpleMSD",
            "version": "1.0.0",
            "status": "Success",
            "data_length": 0
        }
        response_header: ResponseHeader = ResponseHeader(head_values)

        # Simulation Options
        simulation_options_dict: Dict[str, Union[float, str]] = {
            "startTime": 0.0,
            "stopTime": 10.0,
            "stepSize": 0.02,
            "tolerance": 1e-06,
            "solver": "dassl"
        }

        # Parameters
        simulation_parameters_dict: Dict[str, float] = {
            "c": 1.0,
            "k": 2.0,
            "m": 1.0,
            "v0": 5.0
        }

        # Default Values
        default_values: DefaultValues \
            = DefaultValues(simulation_options_dict, simulation_parameters_dict)

        # Select Options
        select_tolerance: List[Dict[str, Union[str, float]]] = [
            {'label': y, 'value': float(y)} for y in ["1e-{0}".format(i) for i in range(2, 13)]
        ]
        select_solver: List[Dict[str, str]] = [
            {'label': y, 'value': y.lower()} for y in ["Euler", "Heun", "Rungekutta"]
        ]
        select_options: SelectOptions = SelectOptions(select_tolerance, select_solver)

        # Available Solutions
        available_solutions_full_list: List[str] = ['c', 'der(v)', 'der(x)', 'k', 'm', 'time', 'v', 'v0', 'x']
        available_solutions_list: List[str] \
            = [item for item in available_solutions_full_list if item not in simulation_parameters_dict.keys()]
        solution_options: SolutionOptions = SolutionOptions(available_solutions_list)

        # Response Body
        response_body: UISetValueResponseBody \
            = UISetValueResponseBody(default_values, select_options, solution_options)

        # Unite Header And Body
        ui_set_value: UISetValue = UISetValue(response_header, response_body)
        response: UISetValueResponse = UISetValueResponse(ui_set_value)

        # Serialize -> Deserialize
        mapper: UISetValueResponseMapper = UISetValueResponseMapper(response)
        json_string: str = json.dumps(mapper.as_dict())
        json_object = json.loads(json_string)

        # Assertion
        # Header
        head = json_object["ui_set_value"]["head"]
        self.assertEqual(type(head['index']), int)
        self.assertEqual(head['index'], head_values["index"])
        self.assertEqual(type(head['simulation_model_name']), str)
        self.assertEqual(head['simulation_model_name'], head_values["simulation_model_name"])
        self.assertEqual(type(head['status']), str)
        self.assertEqual(head['status'], head_values["status"])
        self.assertEqual(type(head['version']), str)
        self.assertEqual(head['version'], head_values["version"])
        self.assertEqual(type(head['data_length']), int)
        self.assertEqual(head['data_length'], head_values["data_length"])

        # Body
        body = json_object["ui_set_value"]["body"]

        # Simulation Options
        options = body["default_values"]["simulation_options"]
        self.assertEqual(type(options["startTime"]), float)
        self.assertEqual(options["startTime"], simulation_options_dict["startTime"])
        self.assertEqual(type(options["stopTime"]), float)
        self.assertEqual(options["stopTime"], simulation_options_dict["stopTime"])
        self.assertEqual(type(options["stepSize"]), float)
        self.assertEqual(options["stepSize"], simulation_options_dict["stepSize"])
        self.assertEqual(type(options["tolerance"]), float)
        self.assertEqual(options["tolerance"], simulation_options_dict["tolerance"])
        self.assertEqual(type(options["solver"]), str)
        self.assertEqual(options["solver"], simulation_options_dict["solver"])

        # Parameters
        params = body["default_values"]["parameters"]
        self.assertEqual(type(params["c"]), float)
        self.assertEqual(params["c"], simulation_parameters_dict["c"])
        self.assertEqual(type(params['k']), float)
        self.assertEqual(params['k'], simulation_parameters_dict["k"])
        self.assertEqual(type(params['m']), float)
        self.assertEqual(params['m'], simulation_parameters_dict["m"])
        self.assertEqual(type(params['v0']), float)
        self.assertEqual(params['v0'], simulation_parameters_dict["v0"])

        # Select Options
        select_ops = body['select_options']
        self.assertEqual(type(select_ops['tolerance']), list)
        self.assertEqual(len(select_ops['tolerance']), len(select_tolerance))
        self.assertEqual(type(select_ops['tolerance'][0]['value']), float)
        self.assertEqual(select_ops['tolerance'][0]['value'], 1e-2)
        self.assertEqual(type(select_ops['solver']), list)
        self.assertEqual(len(select_ops['solver']), len(select_solver))
        self.assertEqual(type(select_ops['solver'][0]['label']), str)
        self.assertEqual(select_ops['solver'][0]['value'], select_solver[0]['value'].lower())

        # Solution Options
        avl_solutions = body['solution_options']['available_solutions']
        self.assertEqual(type(avl_solutions), list)
        self.assertEqual(len(avl_solutions), len(available_solutions_list))
        self.assertEqual(type(avl_solutions[0]), str)

    def test_response_ui_set_values_simple_msd_error_get_default_values_failed(self):
        """
        １次元バネマスダンパモデルの画面初期化設定値マッパーテスト：異常系ーデフォルト値取得失敗ケース
        :return: None
        """
        # Build Response Objects

        # Response Header
        head_values: Dict[str, Union[str, int]] = {
            "index": 0,
            "simulation_model_name": "SimpleMSD",
            "version": "1.0.0",
            "status": "Failed",
            "data_length": 0
        }
        response_header: ResponseHeader = ResponseHeader(head_values)

        # Simulation Options
        simulation_options_dict: Optional[Dict[str, Union[float, str]]] = None

        # Parameters
        simulation_parameters_dict: Optional[Dict[str, float]] = None

        # Default Values
        default_values: DefaultValues \
            = DefaultValues(simulation_options_dict, simulation_parameters_dict)

        # Select Options
        select_tolerance: List[Dict[str, Union[str, float]]] = [
            {'label': y, 'value': float(y)} for y in ["1e-{0}".format(i) for i in range(2, 13)]
        ]
        select_solver: List[Dict[str, str]] = [
            {'label': y, 'value': y.lower()} for y in ["Euler", "Heun", "Rungekutta"]
        ]
        select_options: SelectOptions = SelectOptions(select_tolerance, select_solver)

        # Available Solutions
        available_solutions_list: Optional[List[str]] = None
        solution_options: SolutionOptions = SolutionOptions(available_solutions_list)

        # Response Body
        response_body: UISetValueResponseBody \
            = UISetValueResponseBody(default_values, select_options, solution_options)

        # Unite Header And Body
        ui_set_value: UISetValue = UISetValue(response_header, response_body)
        response: UISetValueResponse = UISetValueResponse(ui_set_value)

        # Serialize -> Deserialize
        mapper: UISetValueResponseMapper = UISetValueResponseMapper(response)
        json_string: str = json.dumps(mapper.as_dict())
        json_object = json.loads(json_string)

        # Assertion
        # Header
        head = json_object["ui_set_value"]["head"]
        self.assertEqual(type(head['index']), int)
        self.assertEqual(head['index'], head_values["index"])
        self.assertEqual(type(head['simulation_model_name']), str)
        self.assertEqual(head['simulation_model_name'], head_values["simulation_model_name"])
        self.assertEqual(type(head['status']), str)
        self.assertEqual(head['status'], head_values["status"])
        self.assertEqual(type(head['version']), str)
        self.assertEqual(head['version'], head_values["version"])
        self.assertEqual(type(head['data_length']), int)
        self.assertEqual(head['data_length'], head_values["data_length"])

        # Body
        body = json_object['ui_set_value']['body']
        self.assertEqual(body['default_values']['simulation_options'], None)
        self.assertEqual(body['default_values']['parameters'], None)
        self.assertEqual(body['solution_options']['available_solutions'], None)

    def test_response_calc_simple_msd_normal(self):
        """
        １次元バネマスダンパ系計算結果マッパーテスト：正常系
        :return:
        """
        # Build Response Objects

        # ResponseHeader
        data_length: int = 10
        header_values: Dict[str, Union[str, int]] = {
            "index": 0,
            "simulation_model_name": "SimpleMSD",
            "status": "Success",
            "version": "1.0.0",
            "data_length": data_length
        }
        response_header: ResponseHeader = ResponseHeader(header_values)

        # Results
        results_values: Optional[Dict[str, List[float]]] = {
            'time': [0.0 + 0.1 * i for i in range(data_length)],
            'x': [1.0 - 0.01 * i for i in range(data_length)],
            'v': [5.0 + 0.3 * i for i in range(data_length)]
        }
        simulation_results: SimulationResults = SimulationResults(results_values)
        response_body: SimulationResponseBody = SimulationResponseBody(simulation_results)

        # Response
        output: SimulationOutput = SimulationOutput(response_header, response_body)
        response: SimulationResponse = SimulationResponse(output)

        # Serialize -> Deserialize
        mapper: SimulationResponseMapper = SimulationResponseMapper(response)
        json_string = json.dumps(mapper.as_dict())
        json_object = json.loads(json_string)

        # Assertion
        # Header
        header = json_object["simulation_output"]["head"]
        self.assertEqual(header["index"], header_values['index'])
        self.assertEqual(type(header["index"]), int)
        self.assertEqual(header["simulation_model_name"], header_values['simulation_model_name'])
        self.assertEqual(type(header["simulation_model_name"]), str)
        self.assertEqual(header["status"], header_values['status'])
        self.assertEqual(type(header["status"]), str)
        self.assertEqual(header["version"], header_values['version'])
        self.assertEqual(type(header["version"]), str)
        self.assertEqual(header["data_length"], header_values['data_length'])
        self.assertEqual(type(header["data_length"]), int)

        # Body - Results
        results = json_object["simulation_output"]["body"]["results"]
        for item in ['time', 'x', 'v']:
            self.assertEqual(len(results[item]), data_length)
            self.assertEqual(type(results[item]), list)
            self.assertEqual(type(results[item][0]), float)

    def test_response_calc_simple_msd_error_calc_failed(self):
        """
        １次元バネマスダンパ系計算結果マッパーテスト：異常系-計算失敗ケース
        :return:
        """
        # Build Response Objects

        # ResponseHeader
        header_values: Dict[str, Union[str, int]] = {
            "index": 0,
            "simulation_model_name": "SimpleMSD",
            "status": "Failed",
            "version": "1.0.0",
            "data_length": 0
        }
        response_header: ResponseHeader = ResponseHeader(header_values)

        # Results
        results_values: Optional[Dict[str, List[float]]] = None
        simulation_results: SimulationResults = SimulationResults(results_values)
        response_body: SimulationResponseBody = SimulationResponseBody(simulation_results)

        # Response
        output: SimulationOutput = SimulationOutput(response_header, response_body)
        response: SimulationResponse = SimulationResponse(output)

        # Serialize -> Deserialize
        mapper: SimulationResponseMapper = SimulationResponseMapper(response)
        json_string = json.dumps(mapper.as_dict())
        json_object = json.loads(json_string)

        # Assertion
        # Header
        header = json_object["simulation_output"]["head"]
        self.assertEqual(header["index"], header_values['index'])
        self.assertEqual(type(header["index"]), int)
        self.assertEqual(header["simulation_model_name"], header_values['simulation_model_name'])
        self.assertEqual(type(header["simulation_model_name"]), str)
        self.assertEqual(header["status"], header_values['status'])
        self.assertEqual(type(header["status"]), str)
        self.assertEqual(header["version"], header_values['version'])
        self.assertEqual(type(header["version"]), str)
        self.assertEqual(header["data_length"], header_values['data_length'])
        self.assertEqual(type(header["data_length"]), int)

        # Body - Results
        results = json_object["simulation_output"]["body"]["results"]
        self.assertEqual(results, None)


if __name__ == '__main__':
    unittest.main()
