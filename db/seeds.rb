# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@users = User.all

1000.times do |index|
  User.create!(email: "#{index}ciaociao@gmail.com", username: "Bellali#{index}", password: "ciaociao", password_confirmation: "ciaociao") unless User.exists?(email: "#{index}ciaociao@gmail.com")
end

puts "CREATI UTENTI"

User.random_records(185).each_with_index do |u, index|
  puts "Processo #{u.id}"
  User.random_records(25).all.map { |following| u.follow(following) unless u.following?(following) unless following.id == u.id
    puts "ADESSO #{u.id} SEGUE #{following.id}"}
  puts "STILL #{185 - index - 1} to go"
end