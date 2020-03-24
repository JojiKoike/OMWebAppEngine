"""
アプリケーション共通で使用される定数群モジュールです。
"""
import os

DELETE_TARGET_FILE_EXTENSIONS = [
    '.c', '.h', '.o', '.libs', '.log', '.makefile', '.json'
]

SOLVER = [{'label': y, 'value': y.lower()} for y in
          ['Euler', 'Heun', 'Rungekutta', 'ImpEuler',
           'Trapezoid', 'ImpRungeKutta', 'Irksco', 'Dassl', 'Ida', 'RungeKuttaSSC']]

MIN_TOLERANCE_ORDER = 2
MAX_TOLERANCE_ORDER = 12
TOLERANCE = [
    {'label': y, 'value': float(y)}
    for y in ["1e-{0}".format(x) for x in range(MIN_TOLERANCE_ORDER, MAX_TOLERANCE_ORDER + 1)]
]

MODELICA_MODEL_DIR_PATH = \
    ("./" if "app" in os.getcwd().split(os.sep) else "./app/") + "omwebapp/ModelicaModels/"
BOOTSTRAP_MODEL_PREFIX = "modelica_"

DEFAULT_PARAMS_POSTFIX = "_default_params"
DEFAULT_OPTIONS_POSTFIX = "_default_options"
AVAILABLE_SOLUTIONS_POSTFIX = "_available_solutions"
