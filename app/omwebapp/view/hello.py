"""
疎通確認用Web APIモジュールです。
"""
from .view_base import ViewBase


class HelloWorld(ViewBase):
    """
    疎通確認用APIクラス
    """
    def __init__(self):
        ViewBase.__init__(self, **{'name': __name__})

    def get(self):
        """
        疎通確認用GETメソッド定義
        :return: JSON文字列
        """
        self.logger.info("Connection Test Start")
        return {'hello': 'world'}
