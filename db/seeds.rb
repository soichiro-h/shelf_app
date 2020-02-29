# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(nickname:  "シェルフくん",
             email: "example@shelf.com",
             password:              "password",
             password_confirmation: "password")

Tag.create!(tag_title: "小説",
            user_id: "1")
            
Tag.create!(tag_title: "ビジネス",
            user_id: "1")

Tag.create!(tag_title: "自己啓発",
            user_id: "1")
            
Tag.create!(tag_title: "英語",
            user_id: "1")

Tag.create!(tag_title: "フランス語",
            user_id: "1")
            
Tag.create!(tag_title: "お気に入り",
            user_id: "1")

Tag.create!(tag_title: "絶対役立つ",
            user_id: "1")
            
Tag.create!(tag_title: "男性コミック",
            user_id: "1")

Tag.create!(tag_title: "少女コミック",
            user_id: "1")
            
Tag.create!(tag_title: "雑誌",
            user_id: "1")

            
2.times do |n|
  
Tag.create!(tag_title: "小説#{n+1}",
            user_id: "1")
            
Tag.create!(tag_title: "ビジネス#{n+1}",
            user_id: "1")

Tag.create!(tag_title: "自己啓発#{n+1}",
            user_id: "1")
            
Tag.create!(tag_title: "英語#{n+1}",
            user_id: "1")

Tag.create!(tag_title: "フランス語#{n+1}",
            user_id: "1")
            
Tag.create!(tag_title: "お気に入り#{n+1}",
            user_id: "1")

Tag.create!(tag_title: "絶対役立つ#{n+1}",
            user_id: "1")
            
Tag.create!(tag_title: "男性コミック#{n+1}",
            user_id: "1")

Tag.create!(tag_title: "少女コミック#{n+1}",
            user_id: "1")
            
Tag.create!(tag_title: "雑誌#{n+1}",
            user_id: "1")
  
end