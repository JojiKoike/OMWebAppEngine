"""
時間計測ユーティリティモジュールです。
"""
import time


class Timer(object):
    """
    時間計測ユーティリティクラス
    """
    def __init__(self, verbose: bool = False) -> None:
        """
        コンストラクタ
        :param verbose: 冗長出力（デフォルトはFalse）
        """
        self.verbose: bool = verbose

    def __enter__(self):
        """
        計測開始処理
        :return: Timerオブジェクト
        """
        self.start: int = time.time()
        return self

    def __exit__(self, *args) -> None:
        """
        計測終了処理
        :param args
        :return: None
        """
        self.end: int = time.time()
        self.secs: int = self.end - self.start
        self.msecs: int = self.secs * 1000
        if self.verbose:
            print('elapsed time: %f ms' % self.msecs)
