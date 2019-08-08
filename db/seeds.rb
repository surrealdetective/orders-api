# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

worker = Worker.new(name: 'Joseph Joestar', company_name: "Bizarre Adventures", email: 'jojo@bizarre.com' )
worker.save
10.times do |n|
  worker.work_orders.create(title: Faker::Lorem.word, description: Faker::Lorem.word, deadline: DateTime.new(2030, 10, n+1))
end

4.times do
  worker = Worker.new(name: Faker::Lorem.word, company_name: Faker::Lorem.word, email: Faker::Internet.email )
  worker.save
  10.times do |n|
    worker.work_orders.create(title: Faker::Lorem.word, description: Faker::Lorem.word, deadline: DateTime.new(2030, 10, n+1))
  end
end
