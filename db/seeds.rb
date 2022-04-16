# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |i|
    User.create!(
        name:         Faker::Name.first_name,
        surname:      Faker::Name.last_name,
        email:        Faker::Internet.email,
        birthday:     Faker::Date.birthday(min_age: 18, max_age: 65),
        rank:         i+1,
        games_played: 0
    )
end
