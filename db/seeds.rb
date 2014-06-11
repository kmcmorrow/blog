# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Article.create(title: 'Welcome!',
               text: 'This is my first blog post in my new Ruby on Rails blog.')

Article.create(title: 'Second post!',
               text: 'This is the follow-on from the first post. The second post.')
Article.create(title: 'Third post!',
               text: 'And now here is the third post.')
