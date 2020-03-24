"""
カスタムロガーモジュールです。
"""
import logging
from logging import Logger


def get_logger(name: str, level: int) -> Logger:
    """
    ロガーオブジェクトのファクトリーメソッドで
    :param name: ロギング対象モジュール（通常、__name__を入れる）
    :param level: ログレベル
    :return: Loggerオブジェクト
    """
    logger = logging.getLogger(name)
    logger.setLevel(level)
    ch = logging.StreamHandler()
    ch.setLevel(level)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return logger


def get_debug_logger(name: str) -> Logger:
    """
    DEBUGレベルのロガーオブジェクトのファクトリーメソッドです。
    :param name: ロギング対象モジュール（通常、__name__を設定）
    :return: Loggerオブジェクト
    """
    return get_logger(name, logging.DEBUG)


def get_info_logger(name: str) -> Logger:
    """
    INFOレベルのロガーオブジェクトのファクトリーメソッドです。
    :param name: ロギング対象モジュール（通常、__name__を設定）
    :return: Loggerオブジェクト
    """
    return get_logger(name, logging.INFO)
