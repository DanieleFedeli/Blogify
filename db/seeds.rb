# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#1000.times do |index|
#  User.create!(email: "#{index}ciaociao@gmail.com", username: "Bellali#{index}", password: "ciaociao", password_confirmation: "ciaociao") unless User.exists?(email: "#{index}ciaociao@gmail.com")
#end

#puts "CREATI UTENTI"

User.all.each do |u|
#  User.random_records(184).all.map { |following| u.follow(following) unless u.following?(following) unless following.id == u.id}
  12.times do
    u.posts.create do |post|
      post.title = Faker::Community.characters
      post.body = Faker::Lorem.sentence(40)
      list = []
      5.times do 
        list << Faker::RockBand.name
      end
      post.tag_list = list
    end
  end
end