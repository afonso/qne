json.array!(@proposals) do |proposal|
  json.extract! proposal, :id, :user_id, :demand_id, :status, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
  json.url proposal_url(proposal, format: :json)
end
