FactoryBot.define do

  factory :match do
    team1 { Team.where(id: 1).first }
    team2 { Team.where(id: 2).first }

    sequence(:name) { |i| "Match name number: #{i}" }

    trait :with_team_and_players do
      team1 { create(:team, :with_players) }
      team2 { create(:team, :with_players) }

      after(:create) do |match|
        indicator = create(:indicator)
        player = match.team1.players.first
        create(:indicator_value, :false_val, indicator: indicator, player: player, match: match)
      end
    end
  end
end
