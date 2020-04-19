FactoryBot.define do

  factory :indicator do
    sequence(:name) { |i| "Indicator name number: #{i}" }

    trait :with_values do
      after(:create) do |indicator|
        create_list(:indicator_value, 2, indicator: indicator)
      end
    end
  end
end
