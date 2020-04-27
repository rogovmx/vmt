class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :indicator_values, through: :players
  has_many :first_team_in_match, class_name: "Match", foreign_key: "team1_id"
  has_many :second_team_in_match, class_name: "Match", foreign_key: "team2_id"

  validates :name, presence: true

  def matches
    Match
      .where(id: first_team_in_match.pluck(:id) + second_team_in_match.pluck(:id))
      .order(created_at: :desc)
  end
end
