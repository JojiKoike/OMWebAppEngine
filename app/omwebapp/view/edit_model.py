"""
Modelicaモデル編集サンプルAPIモジュールです。
"""

from .view_base import ViewBase
from http import HTTPStatus

from OMPython import OMCSessionZMQ

# Start OpenModelica Compiler Session Queue Server
omc: OMCSessionZMQ = OMCSessionZMQ()


class EditModel(ViewBase):
    """
    Modelicaモデル編集API実装サンプルクラス
    """

    def __init__(self):
        ViewBase.__init__(self, **{'name': __name__})

    def post(self):
        """
        Modelicaモデル編集API実装サンプル
        :return: JSON文字列
        """
        model_name: str = "mymodel"
        model_dir: str = "./omwebapp/ModelicaModels"

        # Step1 : .moファイル読み込み
        omc.sendExpression("loadFile(\"{0}\")".format(model_dir + "/" + model_name + ".mo"))
        omc.sendExpression("loadModel({0})".format(model_name))

        # Step2 : モデル編集（この例では、インダクターを追加して既存の抵抗と接続する）
        omc.sendExpression("addComponent({0},{1},{2},anotate=Code(()))"
                           .format("i1", "Modelica.Electrical.Analog.Basic.Inductor", model_name))
        omc.sendExpression("addConnection({0},{1},{2})".format("i1.p", "r1.n", model_name))
        omc.sendExpression("save({0})".format(model_name))

        return {"Result": "OK"}, HTTPStatus.OK
