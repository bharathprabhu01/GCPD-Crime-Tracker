FactoryBot.define do
  factory :assignment do
    association :investigation
    association :officer
    start_date Date.current
    end_date nil
  end
end
