class Match < ApplicationRecord
  has_many :indicator_values
  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"

  validates :team1_id, :team2_id, :name, presence: true
  validate :check_team1_and_team2

  def teams
    Team.where(id: [team1, team2])
  end

  # отметить, что игрок выполнил такой-то показатель в матче
  def player_indicator_complete!(player, indicator)
    if indicator_values.find_by(player: player, indicator: indicator)&.update(val: true)
      return
    end

    indicator_values.create(player: player, indicator: indicator, val: true)
  end

  # игрок выполнил такой-то показатель в матче?
  def player_indicator_completed?(player, indicator)
    indicator_values.find_by(player: player, indicator: indicator, val: true).present?
  end

  private

  def check_team1_and_team2
    errors.add(:team2, "can't be the same as team1") if team1_id == team2_id
  end
end
