json.extract! user, :id, :name, :surname, :email, :birthday, :games_played, :rank, :created_at, :updated_at
json.url user_url(user, format: :json)
