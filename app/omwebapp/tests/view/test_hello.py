"""
疎通確認用APIのテストコードモジュールです。
"""
from flask.testing import FlaskClient


class TestViewHelloGroup(object):
    """
    疎通確認用APIのテストグループクラス
    """
    def test_hello(self, client: FlaskClient):
        res = client.get('/hello')
        assert res.status_code == 200
        assert b'{"hello": "world"}\n' == res.data

