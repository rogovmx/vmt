FactoryBot.define do

  factory :team do
    sequence(:name) { |i| "Team name number: #{i}" }

    trait :with_players do
      after(:create) do |team|
        create_list(:player, 5, team: team)
      end
    end

    trait :with_all_relations_indicator_false do
      after(:create) do |team|
        players = create_list(:player, 5, team: team)
        indicator = create(:indicator)
        create(:team, :with_players)
        matches = create_list(:match, 5)

        matches.each do |match|
          create(:indicator_value, :false_val, indicator: indicator, player: players.first, match: match)
        end
      end
    end

    trait :with_all_relations_indicator_rand do
      after(:create) do |team|
        players = create_list(:player, 5, team: team)
        indicator = create(:indicator)
        create(:team, :with_players)
        matches = create_list(:match, 5)

        matches.each do |match|
          players.each do |player|
            create(:indicator_value, :rand_val, indicator: indicator, player: player, match: match)
          end
        end
      end
    end

    trait :teams_with_all_relations_indicator_rand do
      after(:create) do |team|
        players = create_list(:player, 5, team: team)
        indicator = create(:indicator)
        team2 = create(:team, :with_players)
        players2 = team2.players
        matches = create_list(:match, 5)

        matches.each do |match|
          players.each do |player|
            create(:indicator_value, :rand_val, indicator: indicator, player: player, match: match)
          end

          players2.each do |player|
            create(:indicator_value, :rand_val, indicator: indicator, player: player, match: match)
          end
        end
      end
    end

    trait :teams_with_all_relations_indicator do
      after(:create) do |team|
        players = create_list(:player, 5, team: team)
        indicator = create(:indicator)
        team2 = create(:team, :with_players)
        players2 = team2.players
        matches = create_list(:match, 5)

        matches.each do |match|
          create(:indicator_value, :rand_val, indicator: indicator, player: players[0], match: match)

          create(:indicator_value, :rand_val, indicator: indicator, player: players2[0], match: match)
        end
      end
    end

  end
end
