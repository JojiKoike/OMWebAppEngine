"""
ローカル開発環境向けFlaskアプリケーションブートストラップモジュール
"""
import os
import sys
import traceback
from typing import Dict, Optional, Union
from flask import Flask
from flask_cors import CORS
from flask_restful import Api
from OMPython import ModelicaSystem
from .config.routing import configure_routing
from .config.model import get_model_map, get_default_input_values_map, get_available_solutions_map

def create_app(test_config=None) -> Flask:

    """
    Flaskアプリケーションの組み込みテスト用サーバー環境下での起動処理
    :param test_config: テスト用設定
    :return: Flaskアプリケーションインスタンス
    """

    # Create and Configure Application
    app: Flask = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
    )
    # Angular, React等のフレームワーク組み込みテスト用サーバーは
    # どうしてもFlask組み込みサーバーと別マシン扱いになる為、
    # Flask組み込みサーバー用の設定に限り、CORS設定を許可する。
    CORS(app)
    api: Api = Api(app)

    if test_config is None:
        # Load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # Load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # Modelica Model Activation
    model_map: Optional[Dict[str, ModelicaSystem]] = None
    try:
        model_map = get_model_map()
    except Exception as e:
        print(e)
        sys.stderr.write(traceback.format_exc())

    # Model Default Option and Param Values Map
    default_input_values_map: Optional[Dict[str, Dict[str, Union]]] = None
    try:
        default_input_values_map = get_default_input_values_map(model_map)
    except Exception as e:
        print(e)
        sys.stderr.write(traceback.format_exc())

    # Model Available Solutions Map
    available_solutions_map: Optoinal[Dict[str, List[str]]] = None
    try:
        available_solutions_map = get_available_solutions_map(model_map)
    except Exception as e:
        print(e)
        sys.stderr.write(traceback.format_exc())

    # Configure Routing
    configure_routing(api, model_map, default_input_values_map, available_solutions_map)

    return app