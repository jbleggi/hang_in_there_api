# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Poster.destroy_all

Poster.create!(
  name: "DETERMINATION",
  description: "Persistence is the key to failure.",
  price: 99.00,
  year: 2020,
  vintage: false,
  img_url: "https://plus.unsplash.com/premium_photo-1679237489023-4d6b9f7e8292"
)

Poster.create!(
  name: "AMBITION",
  description: "The climb is always steeper than it looks.",
  price: 120.00,
  year: 2019,
  vintage: true,
  img_url: "https://plus.unsplash.com/premium_photo-1672340957102-ecb87429dbf1"
)

Poster.create!(
  name: "INSPIRATION",
  description: "Dreams are made to be unattainable.",
  price: 85.00,
  year: 2021,
  vintage: false,
  img_url: "https://plus.unsplash.com/premium_photo-1680273494857-a8bf4c7d10e5"
)

Poster.create!(
  name: "COURAGE",
  description: "Risk-taking leads to regret.",
  price: 95.00,
  year: 2017,
  vintage: true,
  img_url: "https://plus.unsplash.com/premium_photo-1669050824171-d40e32bb85c6"
)

Poster.create!(
  name: "HOPE",
  description: "Hopes are the foundation of disappointment.",
  price: 89.00,
  year: 2022,
  vintage: false,
  img_url: "https://plus.unsplash.com/premium_photo-1670982039853-e3e46b24fabc"
)

puts "seeded successfully"