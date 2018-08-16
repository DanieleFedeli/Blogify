# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User.all.each do |u|
#  u.destroy!
#end

#100.times do 
#  User.create!(username: Faker::Internet.username, email: Faker::Internet.safe_email, password: 'ciaociao123', password_confirmation: 'ciaociao123')
#end

User.all.each do
  10.times do
    Post.create do |post|
      post.title = Faker::WorldCup.team
      post.body = Faker::Lorem.paragraphs(3)
      list = []
      4.times do 
        list << Faker::Company.name
      end
      post.tag_list = list
    end
  end
end