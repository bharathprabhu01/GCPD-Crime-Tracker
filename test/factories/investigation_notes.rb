FactoryBot.define do
  factory :investigation_note do
    association :investigation
    association :officer
    content "I found the weapon used, but it was wiped clean for fingerprints."
    date Date.current
  end
end
