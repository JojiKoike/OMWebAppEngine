import unittest
from app.omwebapp.entity.request.request import RunSimulationRequestMapper


class SimpleMSDRequestTestCase(unittest.TestCase):

    def test_request_simple_msd(self):

        # Prepare Request JSON Data
        request: dict = {"simulation_input": {
            "head": {
                "index": 0,
                "simulation_model_name": "SimpleMSD",
                "version": "1.0.0"
            },
            "body": {
                "simulation_options": {
                    "startTime": 0.0,
                    "stopTime": 10.0,
                    "stepSize": 0.02,
                    "tolerance": 0.000001,
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
        }}

        # Parse JSON
        result = RunSimulationRequestMapper(request).as_dict()

        # Assertion
        head = result['simulation_input']['head']
        self.assertEqual(head['index'], 0)
        self.assertEqual(type(head['index']), int)
        self.assertEqual(head['simulation_model_name'], 'SimpleMSD')
        self.assertEqual(type(head['simulation_model_name']), str)
        self.assertEqual(head['version'], '1.0.0')
        self.assertEqual(type(head['version']), str)

        body = result['simulation_input']['body']
        simulation_options = body['simulation_options']
        self.assertEqual(simulation_options['startTime'], 0.0)
        self.assertEqual(type(simulation_options['startTime']), float)
        self.assertEqual(simulation_options['stopTime'], 10.0)
        self.assertEqual(type(simulation_options['stopTime']), float)
        self.assertEqual(simulation_options['stepSize'], 0.02)
        self.assertEqual(type(simulation_options['stepSize']), float)
        self.assertEqual(simulation_options['tolerance'], 0.000001)
        self.assertEqual(type(simulation_options['tolerance']), float)
        self.assertEqual(simulation_options['solver'], 'dassl')
        self.assertEqual(type(simulation_options['solver']), str)

        parameters = body['parameters']
        self.assertEqual(parameters['m'], 1.0)
        self.assertEqual(type(parameters['m']), float)
        self.assertEqual(parameters['k'], 2.0)
        self.assertEqual(type(parameters['k']), float)
        self.assertEqual(parameters['c'], 1.0)
        self.assertEqual(type(parameters['c']), float)
        self.assertEqual(parameters['v0'], 5.0)
        self.assertEqual(type(parameters['v0']), float)

        target_results = body["results_options"]["target_results"]
        self.assertEqual(len(target_results),
                         len(request['simulation_input']["body"]["results_options"]["target_results"]))
        self.assertEqual(type(target_results), list)
        for i in range(len(target_results)):
            self.assertEqual(target_results[i],
                             request['simulation_input']['body']["results_options"]['target_results'][i])


if __name__ == '__main__':
    unittest.main()
