# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "faker"

User.destroy_all
Team.destroy_all

puts "Seeding Users..."

5.times do
    @user = User.create!(
      username: Faker::Internet.username,
      password: "password",
      password_confirmation: "password"
    )

    UserWallet.create!(balance:0, entity_id: @user.id, account_number:  rand.to_s[2..11])
end

puts "Seeding Users completed!"

puts "Seeding teams...."
5.times do
    @team = Team.create!(
      name: Faker::Internet.username,
    )
    TeamWallet.create!(balance:0, entity_id:@team.id, account_number:  rand.to_s[2..11])

end

puts "Complete seeding teams"

puts "Seeding Stocks..."
@stock = Stock.create!(
  symbol: "Rp",
  name:"Rupiah"
)

StockWallet.create!(balance:0, entity_id:@stock.id, account_number:  rand.to_s[2..11])