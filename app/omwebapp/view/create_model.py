"""
Modelicaモデル生成サンプルAPIモジュールです。
"""

from .view_base import ViewBase
from http import HTTPStatus

from OMPython import OMCSessionZMQ

# Start OpenModelica Compiler Session Queue Server
omc: OMCSessionZMQ = OMCSessionZMQ()


class CreateModel(ViewBase):
    """
    Modelicaモデル生成API実装サンプルクラス
    """

    def __init__(self):
        ViewBase.__init__(self, **{'name': __name__})

    def post(self):
        """
        モデル生成APIサンプル
        :return: JSON文字列
        """
        self.logger.info("Modelica Model Creation Sample")
        model_name: str = "mymodel"
        model_dir: str = "./omwebapp/ModelicaModels"

        # Step 1 : 空の.moファイル生成
        omc.sendExpression("createModel({0})".format(model_name))
        omc.sendExpression("setSourceFile({0},\"{1}\")".format(model_name, model_dir + "/" + model_name + ".mo"))
        omc.sendExpression("save({0})".format(model_name))

        # Step2 : エレメントの配置（この例では、キャパシターと抵抗を配置）
        omc.sendExpression("addComponent({0},{1},{2},anotate=Code(()))"
                           .format("c1", "Modelica.Electrical.Analog.Basic.Capacitor", model_name))
        omc.sendExpression("addComponent({0},{1},{2},anotate=Code(()))"
                           .format("r1", "Modelica.Electrical.Analog.Basic.Resistor", model_name))
        omc.sendExpression("save({0})".format(model_name))

        # Step3 : 配置したエレメントの接続定義
        omc.sendExpression("addConnection({0},{1},{2})".format("c1.n", "r1.p", model_name))
        omc.sendExpression("save({0})".format(model_name))

        return {"Result": "OK"}, HTTPStatus.CREATED
