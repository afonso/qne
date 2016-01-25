json.array!(@information) do |information|
  json.extract! information, :id, :user_id, :city, :state, :school, :expected_finish, :work_at, :occupation
  json.url information_url(information, format: :json)
end
