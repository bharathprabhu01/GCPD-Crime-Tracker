FactoryBot.define do
  factory :investigation do
    title "Lacey Towers Murder"
    description "Tiffany Ambrose was murdered in Lacey Towers. Ms. Ambrose was known to be one of Roman Sionis' girlfriends. Long list of priors, but unclear if she was the primary target here or the other unidentified male found dead with her."
    crime_location "Lacey Towers"
    date_opened Date.current
    date_closed nil
    solved false
    batman_involved false
  end
end
