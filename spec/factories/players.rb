FactoryBot.define do

  factory :player do
    team

    sequence(:name) { |i| "Test player name number #{i}" }
  end
end
