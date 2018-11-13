json.array!(@crimes) do |crime|
  json.extract! crime, :id, :crime_id, :investigation_id, :crime_name
  json.url crime_investigations_url(crime, format: :json)
end