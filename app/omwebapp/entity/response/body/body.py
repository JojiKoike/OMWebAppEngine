"""
Web APIレスポンスのボディ部ルートマッパーモジュールです。
"""
from bpmappers import Mapper, DelegateField

from .default_values import DefaultValues, DefaultValuesMapper
from .select_options import SelectOptions, SelectOptionsMapper
from .solution_options import SolutionOptions, SolutionOptionsMapper
from .results import SimulationResults, SimulationResultsMapper


class SimulationResponseBody(object):
    """
    シミュレーション結果レスポンスボディオブジェクト
    """
    def __init__(self, results: SimulationResults) -> None:
        """
        コンストラクタ
        :param results: 計算結果
        """
        self.results = results


class SimulationResponseBodyMapper(Mapper):
    """
    シミュレーション結果レスポンスとJSONを紐づけるマッパーオブジェクト
    """
    results = DelegateField(SimulationResultsMapper, attach_parent=True)


class UISetValueResponseBody(object):
    """
    画面初期値レスポンスボディオブジェクト
    """
    def __init__(self,
                 default_values: DefaultValues,
                 select_options: SelectOptions,
                 solution_options: SolutionOptions) -> None:
        """
        コンストラクタ
        :param default_values: デフォルト値
        :param select_options: シミュレーションオプション選択肢
        :param solution_options: 利用可能な計算結果アイテム
        """
        self.default_values = default_values
        self.select_options = select_options
        self.solution_options = solution_options


class UISetValueResponseBodyMapper(Mapper):
    """
    画面初期値レスポンスボディマッパーオブジェクト
    """
    default_values = DelegateField(DefaultValuesMapper)
    select_options = DelegateField(SelectOptionsMapper)
    solution_options = DelegateField(SolutionOptionsMapper)
