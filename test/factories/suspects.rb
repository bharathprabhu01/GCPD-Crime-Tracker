FactoryBot.define do
  factory :suspect do
    association :investigation
    association :criminal
    added_on Date.current
    dropped_on nil
  end
end
