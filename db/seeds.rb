# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者のメールアドレスとパスワード
Admin.create!(email: 'admin@test.com', password: 'testtest',)

User.create!(email: 'user@test.com', password: 'testtest', account_name: 'testuser',user_name: 'テストユーザー',gender: '1',birth_year: '1990')
Genre.create!(id: '1', name: '未分類')
Genre.create!(id: '2', name: 'scene')
Genre.create!(id: '3', name: 'Porpose')
Tag.create!(id: '1', tag_name: 'キッチン', genre_id: '2')
