FactoryBot.define do
  factory :user do
    role "officer"
    username "jblake"
    password "secret"
    password_confirmation "secret"
    active true
  end
end
