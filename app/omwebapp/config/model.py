from typing import Dict, List, Union
import os
from OMPython import ModelicaSystem
from .constants import MODELICA_MODEL_DIR_PATH, BOOTSTRAP_MODEL_PREFIX,\
    DEFAULT_OPTIONS_POSTFIX, DEFAULT_PARAMS_POSTFIX, AVAILABLE_SOLUTIONS_POSTFIX
from ..util.file import clean_all_files, clean_files


def get_model_map() -> Dict[str, ModelicaSystem]:
    """
    各モデル向けのModelicaSystemオブジェクトと
    :return: Dict[
    """
    # Mapの初期化
    modelica_model_system_map: Dict[str, ModelicaSystem] = {}

    # Model Directory Traversal
    model_dir_files: List[str] = os.listdir(MODELICA_MODEL_DIR_PATH)

    # パッケージ化されていない単一ファイルのモデルの初期化、マップ構築
    non_packaged_models: List[str] = list(filter(lambda name: '.mo' in name, model_dir_files))
    for non_packaged_model in non_packaged_models:
        model_name: str
        model_name, _ = non_packaged_model.split('.')
        modelica_system = __prepare_model(model_name=model_name)
        modelica_model_system_map[model_name] = modelica_system

    # パッケージ化されたモデルの初期化、マップ構築
    packages: List[str] = list(filter(lambda name: '.mo' not in name, model_dir_files))
    for package in packages:
        bootstraps = list(
            filter(lambda name: BOOTSTRAP_MODEL_PREFIX in name,
                   os.listdir(MODELICA_MODEL_DIR_PATH + package)))
        for bootstrap in bootstraps:
            bootstrap_model_name: str
            bootstrap_model_name, _ = bootstrap.split('.')
            modelica_system = __prepare_model(
                model_name=bootstrap_model_name,
                package_name=package
            )
            full_bootstrap_model_name: str = package + "." + bootstrap_model_name
            modelica_model_system_map[full_bootstrap_model_name] = modelica_system

    return modelica_model_system_map


def get_default_input_values_map(modelica_model_system_map: Dict[str, ModelicaSystem]) \
        -> Dict[str, Dict[str, Union[str, int, float]]]:
    """
    各モデルのデフォルト値マップの生成
    :param modelica_model_system_map: ModelicaSystemオブジェクトのマップ
    :return: デフォルト値マップ
    """
    res: Dict[str, Dict[str, Union[str, int, float]]] = {}
    # Default Option , Param Values
    for key, value in modelica_model_system_map.items():
        res[key + DEFAULT_OPTIONS_POSTFIX] = value.getSimulationOptions()
        res[key + DEFAULT_PARAMS_POSTFIX] = value.getParameters()
    return res


def get_available_solutions_map(modelica_model_system_map: Dict[str, ModelicaSystem]) \
        -> Dict[str, List[str]]:
    """
    各モデルの取得可能な結果アイテムリストのマップ生成
    :param modelica_model_system_map:
    :return: 取得可能な結果アイテムリストのマップ
    """
    res: Dict[str, List[str]] = {}
    for key, value in modelica_model_system_map.items():
        res[key + AVAILABLE_SOLUTIONS_POSTFIX] \
            = [item for item in list(value.getSolutions()) if item not in value.getParameters().keys()]
    return res
    

def __prepare_model(
        model_name: str,
        package_name: str = '',
        use_msl: bool = True) -> ModelicaSystem:
    """
    モデルのコンパイル、接続用オブジェクトの生成
    :param model_name: モデル名
    :param package_name: パッケージ名
    :param use_msl: Modelica Starndard Libraryの使用有無（デフォルト：True）
    :return: ModelicaSystem Object
    """

    # 既存のモデル関連ファイルを削除
    # (削除対象：モデル実行ファイル、パラメータ、オプション値格納ファイル、結果ファイル）
    clean_all_files(model_name)

    # Model初期化、オブジェクト取得
    if package_name == "":
        model = ModelicaSystem(
            MODELICA_MODEL_DIR_PATH + "{0}.mo".format(model_name),
            model_name,
            ["Modelica"] if use_msl else [])
    else:
        model = ModelicaSystem(
            MODELICA_MODEL_DIR_PATH + package_name + "/package.mo",
            "{0}.{1}".format(package_name, model_name),
            ["Modelica"] if use_msl else []
        )

    # 出力ターゲットリスト生成の為、初期値で計算回して結果ファイルを生成する
    model.simulate()

    # 中間ファイル削除
    clean_files(model_name)

    return model
