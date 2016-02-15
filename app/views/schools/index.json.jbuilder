json.array!(@schools) do |school|
  json.extract! school, :id, :name, :address, :lati, :longi, :state_id, :city_id, :neighborhood, :cep
  json.url school_url(school, format: :json)
end
