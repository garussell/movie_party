# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: 'Ringo', email: 'ringo@gmail.com')
User.create!(name: 'Paul', email: 'paul@gmail.com')
User.create!(name: 'George', email: 'george@gmail.com')
User.create!(name: 'John', email: 'john@gmail.com')
User.create!(name: 'Yoko', email: 'yoko@gmail.com')