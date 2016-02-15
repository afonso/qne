json.array!(@demands) do |demand|
  json.extract! demand, :id, :title, :observation, :period, :start_at, :how_many, :status, :accepted_by, :created_by, :school_id
  json.url demand_url(demand, format: :json)
end
