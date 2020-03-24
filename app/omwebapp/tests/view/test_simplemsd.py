"""
1次元バネマスダンパ系モデル用WebAPIのテストコードモジュールです
"""
from flask.testing import FlaskClient
import json
from http import HTTPStatus

from app.omwebapp.config.constants import TOLERANCE, SOLVER


class TestSimpleMSDViewTestGroup(object):
    """
    １次元バネマスダンパ系モデル用のWebAPIテストグループクラス
    """
    def test_simplemsd_get_normal(self, client: FlaskClient):
        """
        画面初期値取得APIテスト（正常系）
        """
        res = client.get('/simplemsd')
        assert res.status_code == HTTPStatus.OK
        data = json.loads(res.data)['ui_set_value']
        # Head
        data_head = data['head']
        for key, value in {"index": 0,
                           "simulation_model_name": "SimpleMSD",
                           "status": "Success", "version": "1.0.0", "data_length": 0}.items():
            assert data_head[key] == value
        # Body
        data_body = data['body']
        # Body - Default Values
        data_body_default_values = data_body['default_values']
        # Body - Default Values - Simulation Options
        data_body_default_values_options = data_body_default_values['simulation_options']
        for key, value in {"startTime": 0, "stopTime": 10.0,
                           "stepSize": 0.02, "tolerance": 1e-6, "solver": "dassl"}.items():
            assert data_body_default_values_options[key] == value

        # Body - Params
        data_body_default_values_params = data_body_default_values['parameters']
        for key, value in {"k": 2.0, "c": 1.0, "m": 1.0, "v0": 5.0}.items():
            assert data_body_default_values_params[key] == value

        # Body - Select Options
        data_body_select_options = data_body['select_options']
        for i, tolerance in enumerate(TOLERANCE):
            assert data_body_select_options['tolerance'][i]['label'] == tolerance['label']
            assert data_body_select_options['tolerance'][i]['value'] == tolerance['value']
        for j, solver in enumerate(SOLVER):
            assert data_body_select_options['solver'][j]['label'] == solver['label']
            assert data_body_select_options['solver'][j]['value'] == solver['value']

        # Body - Solution Optoins
        data_body_solution_options = data_body['solution_options']
        for item in ["time", "x", "v"]:
            assert item in data_body_solution_options['available_solutions']

    def test_simplemsd_post_normal(self, client: FlaskClient):
        """
        計算実行APIテスト（正常系）
        """
        req_params = {
            "simulation_input": {
                "head": {
                    "index": 0,
                    "simulation_model_name": "SimpleMSD",
                    "version": "1.0.0"
                },
                "body": {
                    "simulation_options": {
                        "startTime": 0,
                        "stopTime": 10.0,
                        "stepSize": 0.02,
                        "tolerance": 1e-6,
                        "solver": "dassl"
                    },
                    "parameters": {
                        "m": 1.0,
                        "k": 2.0,
                        "c": 1.0,
                        "v0": 5.0
                    },
                    "results_options": {
                        "target_results": ["time", "v", "x"]
                    }
                }
            }
        }
        res = client.post('/simplemsd', data=json.dumps(req_params), content_type='application/json')
        assert res.status_code == HTTPStatus.CREATED
        data = json.loads(res.data)['simulation_output']
        head = data['head']
        assert head['index'] == 0
        assert head['simulation_model_name'] == 'SimpleMSD'
        assert head['status'] == 'Success'
        assert head['version'] == '1.0.0'
        assert head['data_length'] == 502
        body = data['body']
        results = body['results']
        for item in ['time', 'x', 'v']:
            assert len(results[item]) == 502
            assert type(results[item]) == list
            assert type(results[item][0]) == float
