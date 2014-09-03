# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: 'admin@example.org',
            password: 'password',
            password_confirmation: 'password')

8.times do |i|
  Category.create name: Faker::Hacker.adjective.upcase
end

15.times do |i|
  article = Article.create(title: "#{Faker::Hacker.verb} the #{Faker::Hacker.noun}".titleize,
                 text: Faker::Lorem.paragraphs(6).join("\n\n"),
                 categories: Category.all.shuffle[0..rand(5)])

  0..rand(10).times do |i|
    article.comments << Comment.create(name: Faker::Name.name,
                                       text: Faker::Lorem.paragraph(rand(10)))
  end
  
end


