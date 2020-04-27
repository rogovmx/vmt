class Player < ApplicationRecord
  belongs_to :team
  has_many :indicator_values
  has_many :indicators, through: :indicator_values

  validates :name, presence: true

  TOP_NUM = 5

  # выбрать Top-5 игроков по конкретному показателю в конкретной команде и по всем командам в целом
  def self.top_by_indicator(indicator, team = nil)
    result =
      left_joins(:indicator_values)
      .where(indicator_values: { indicator: indicator, val: true })
      .group('players.id')
      .order('COUNT(indicator_values.id) DESC')
      .limit(TOP_NUM)
    result = result.where(team: team) if team
    result
  end

  # проверить выполнил ли игрок конкретный показатель хотя бы 1 раз за предыдущие 5 матчей команды
  def check_indicator_completed(indicator)
    team
      .matches
      .limit(5)
      .includes(indicator_values: :indicator)
      .where(indicator_values: { indicator: indicator, player: self, val: true })
      .any?
  end
end
