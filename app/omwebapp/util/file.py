"""
ファイル操作ユーティリティモジュールです。
"""
import glob
import os
from ..util.logger import get_info_logger
from ..config.constants import DELETE_TARGET_FILE_EXTENSIONS

logger = get_info_logger(__name__)


def clean_all_files(name: str) -> None:
    """
    ある文字列を含むファイル名のファイルをすべて削除するメソッド
    :param name: 削除対象のファイル名に含まれる文字列
    :return: None
    """
    for del_target_file in glob.glob("*{0}*".format(name)):
        if os.path.isfile(del_target_file):
            os.remove(del_target_file)
            logger.info("{0} has been removed".format(del_target_file))


def clean_files(name: str) -> None:
    """
    ある文字列を含み、かつDELETE_TARGET_FILE_EXTENSIONSにリストアップされた拡張子のファイルを削除するメソッド
    :param name: 削除対象のファイル名に含まれる文字列
    :return: None
    """
    for del_target_extenison in DELETE_TARGET_FILE_EXTENSIONS:
        for del_target_file in glob.glob("*{0}*{1}".format(name, del_target_extenison)):
            if os.path.isfile(del_target_file):
                os.remove(del_target_file)
                logger.info("{0} has been removed".format(del_target_file))
