FactoryBot.define do

  factory :indicator_value do
    val { false }
    indicator
    player
    match

    trait :true_val do
      val { true }
      indicator
      player
      match
    end

    trait :false_val do
      val { false }
      indicator
      player
      match
    end

    trait :rand_val do
      val { [true, false].sample }
      indicator
      player
      match
    end
  end
end
