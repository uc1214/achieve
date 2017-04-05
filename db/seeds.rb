# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Userテーブルのレコードの初期化
User.delete_all

#Blogテーブルのレコードの初期化
Blog.delete_all

100.times do |m|
  email = Faker::Internet.email
  password = "password"
  name = "hoge"
  User.create!(id: m,
               email: email,
               name: name,
               password: password,
               password_confirmation: password,
               )
  Blog.create(
    title: "hoge",
    content: "hogehogefugafuga",
    user_id: m
  )
end