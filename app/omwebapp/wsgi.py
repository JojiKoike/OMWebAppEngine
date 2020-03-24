"""
WSGI環境（サーバー環境）向けFlaskアプリケーションブートストラップモジュール
"""
from typing import List, Dict, Union
from flask import Flask
from flask_cors import CORS
from flask_restful import Api
from OMPython import ModelicaSystem
from .config.routing import configure_routing
from .config.model import get_model_map, get_default_input_values_map, get_available_solutions_map
from .util.logger import get_info_logger

# Log Configure
logger = get_info_logger(__name__)

# Initialize Flask App Instance
app = Flask(__name__, instance_relative_config=True)
# TODO 本番環境ではXSS脆弱性の原因になるのでCORSを使用しない。
#  ただし、Angular, React等のフレームワーク組み込みのテスト用サーバーは
#  本サーバーアプリケーションが稼働するマシンと別マシンとみなされ、
#  CORS設定抜きでのE2Eテストが出来ない。そこで、本番環境へのリリースまでに、
#  結合試験環境と本番環境で、CORS使用可否を切り替えられるようにする。
CORS(app)
api: Api = Api(app)

# Modelica Model Activation
model_map: Dict[str, ModelicaSystem] = get_model_map()

# Get Default Input Values Map
default_input_values_map: Dict[str, Dict[str, Union[str, int, float]]] = get_default_input_values_map(model_map)

# Get Available Solutions Map
available_solutions_map: Dict[str, List[str]] = get_available_solutions_map(model_map)

# Configure Routing
logger.info("Start Configure Routing")
configure_routing(api, model_map, default_input_values_map, available_solutions_map)
logger.info("Finish Configure Routing")
