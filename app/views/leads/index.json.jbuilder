json.array!(@leads) do |lead|
  json.extract! lead, :id, :name, :objective, :activities, :pricepoint, :email, :startdate
  json.url lead_url(lead, format: :json)
end
