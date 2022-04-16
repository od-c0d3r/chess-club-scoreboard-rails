# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |i|
    User.create!(name: "#{i}name", surname: "#{i}name", email:"#{i}email@email.com", birthday:'1/1/2000', rank: i+1, games_played:0)
end
