FactoryBot.define do
  factory :crime_investigation do
    association :crime
    association :investigation
  end
end
